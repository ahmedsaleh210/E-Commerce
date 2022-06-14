import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/cubit/states.dart';
import 'package:shop_app/models/address_model.dart';
import 'package:shop_app/models/cat_products_model.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/faqs_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/incarts_model.dart';
import 'package:shop_app/models/password_model.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/models/update_profile.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/modules/categories_screen/categories_screen.dart';
import 'package:shop_app/modules/favourite_screen/favourite_screen.dart';
import 'package:shop_app/modules/home_screen/home_screen.dart';
import 'package:shop_app/modules/settings_screen/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';
import 'package:shop_app/shared/network/remote/diohelper.dart';
class HomeCubit extends Cubit<HomeLayoutStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get (context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> shopScreens =
  [
    HomeScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  changeScreen(int index)
  {
    currentIndex = index;
    emit(ChangeScreen());
  }
  HomeModel? homeModel;
  Map <dynamic,dynamic> favoritesReailTime = {};
  Map <dynamic,dynamic> inCartsRealTime = {};
  Map <dynamic,dynamic> name = {};
  Map <dynamic,dynamic> city = {};
  Map <dynamic,dynamic> region = {};
  Map <dynamic,dynamic> details = {};
  Map <dynamic,dynamic> notes = {};
  void getHomeData()
  {

      emit(LoadingHomeDataState());

      DioHelper.getData(
        url: HOME,
        token: token,
      ).then((value) {
        homeModel = HomeModel.fromJson(value.data);
        homeModel!.data.products.forEach((element) {
          favoritesReailTime.addAll({element.id: element.inFavourites});
          inCartsRealTime.addAll({element.id: element.inCart});
        });
        print(token);
        emit(SucessHomeDataState());
      }).catchError((onError) {
        emit(ErrorHomeDataState());
        print(onError.toString());
      });
  }

  ProductDetails? productDetails;

  void getProductData(int? id)
  {
    emit(LoadingProductDataState());

    DioHelper.getData(
      url: 'products/$id',
      token: token,
    ).then((value)
    {
      productDetails = ProductDetails.fromJson(value.data);
      emit(SucessProductDataState());
    }).catchError((onError){
      emit(ErrorProductDataState());
      print(onError.toString());
    });

  }
  CategoriesModel? categoriesModel;
  void getCatgories()
  {
      emit(LoadingHomeDataState());

      DioHelper.getData(
        url: GET_CATEGORIES,
      ).then((value) {
        categoriesModel = CategoriesModel.fromJson(value.data);
        emit(SucessCategoriesDataState());
      }).catchError((onError) {
        emit(ErrorCategoriesDataState());
        print(onError.toString());
      });
  }

  CategoryProducts? categoryProdcuts;
  void getCatgoryProducts(id)
  {
    emit(LoadingCategoryProducts());

    DioHelper.getData(
      url: '$GET_CATEGORIES/$id',
    ).then((value) {
      categoryProdcuts = CategoryProducts.fromJson(value.data);
      emit(SucessCategoryProducts());
    }).catchError((onError) {
      emit(ErrorCategoryProducts());
      print(onError.toString());
    });
  }

  FavoritesModel? favoritesModel;

  void changeFavorites(id)
  {
    favoritesReailTime[id] = !favoritesReailTime[id];
    emit(LoadingFavoritesDataState());
    DioHelper.postData(url: FAVORITES,
        data: {
      'product_id':id
        }, token: token).then((value) {
          favoritesModel = FavoritesModel.fromJson(value.data);
          emit(SucessFavoritesDataState(favoritesModel));
          if (favoritesModel!.status == false) {
            favoritesReailTime[id] = !favoritesReailTime[id];
          } else getFavorites();

    }).catchError((error) {
      emit(ErrorFavoritesDataState());
      favoritesReailTime[id] = !favoritesReailTime[id];
      print(error);
    });
  }


  void getFavorites()
  {
    if(CacheHelper.getData(key: 'token')!=null) {
      emit(LoadingFavoritesScreenDataState());

      DioHelper.getData(
        url: FAVORITES,
        token: token,
      ).then((value) {
        favoritesModel = FavoritesModel.fromJson(value.data);
        emit(SucessFavoritesScreenDataState());
      }).catchError((onError) {
        emit(ErrorFavoritesScreenDataState());
        print(onError.toString());
      });
    }
  }

  InCartsModel? inCartsModel;

  void changeCarts(id)
  {
    inCartsRealTime[id] = !inCartsRealTime[id];
    emit(LoadingCartsDataState());
    DioHelper.postData(url: CARTS,
        data: {
          'product_id':id
        }, token: token).then((value) {
      inCartsModel = InCartsModel.fromJson(value.data);
      emit(SucessCartsDataState(inCartsModel));
      if (inCartsModel!.status == false) {
        inCartsRealTime[id] = !inCartsRealTime[id];
      } else getCarts();

    }).catchError((error) {
      emit(ErrorCartsDataState());
      inCartsRealTime[id] = !inCartsRealTime[id];
      print(error);
    });
  }

  void updateCarts(id,quantiy)
  {
    emit(LoadingUpdateCartsDataState());
    DioHelper.putData(url: '$CARTS/$id',
        data: {
          'quantity':quantiy
        }, token: token).then((value) {
      emit(SucessUpdateCartsDataState());
      getCarts();
    }).catchError((error) {
      emit(ErrorUpdateCartsDataState());
      print(error);
    });
  }

  void getCarts()
  {
    if(CacheHelper.getData(key: 'token')!=null) {
      emit(LoadingCartsScreenDataState());

      DioHelper.getData(
        url: CARTS,
        token: token,
      ).then((value) {
        inCartsModel = InCartsModel.fromJson(value.data);
        // inCartsModel!.data!.cartItems!.forEach((element) {
        //   productQuantity.addAll({element!.id: element.quantity});
        // });
        emit(SucessCartsScreenDataState());
      }).catchError((onError) {
        emit(ErrorCartsScreenDataState());
        print(onError.toString());
      });
    }
  }


  UserModel? userModel;
  void getUserData()
  {
    if(CacheHelper.getData(key: 'token')!=null) {
      emit(LoadingUserDataState());
      DioHelper.getData(
        url: PROFILE,
        token: token,
      ).then((value) {
        userModel = UserModel.fromJson(value.data);
        emit(SucessUserDataState());
      }).catchError((onError) {
        emit(ErrorUserDataState());
        print(onError.toString());
      });
    }
  }

  Faqs? faqsModel;
  void getFaqs()
  {
      emit(LoadingFaqsDataState());

      DioHelper.getData(
        url: FAQS,
        token: token,
      ).then((value) {
        faqsModel = Faqs.fromJson(value.data);
        emit(SucessFaqsDataState());
      }).catchError((onError) {
        emit(ErrorFaqsDataState());
        print(onError.toString());
      });
    }

    UpdateProfile? _updateProfile;

  void updateProfile(
  {
    required String name,
    required String email,
    required String phone,
  }
)
  {
    emit(LoadingUpdateProfileState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data:
      {
        'name':name,
        'email':email,
        'phone':phone,

      },
    ).then((value) {
      _updateProfile = UpdateProfile.fromJson(value.data);
      emit(SucessUpdateProfileState(_updateProfile));
      if (_updateProfile!.status == true) {
        userModel = UserModel.fromJson(value.data);
        CacheHelper.saveData(key: 'name', value: _updateProfile?.data?.name)
            .then((value) {
          accountName = CacheHelper.getData(key: 'name');
          emit(SucessUpdateNameState());
        });
      }
    }).catchError((onError)
    {
      emit(ErrorUpdateProfileState());
      print(onError.toString());
    });
  }

  PasswordModel? passwordModel;
  
  void changePassword({
    required String oldPassword,
    required String newPassword,
  })
  {
    emit(LoadingChangePasswordState());
    DioHelper.postData(
        url: PASSWORD,
        token: token,
        data: {
        'current_password' : oldPassword,
        'new_password' : newPassword,
        }).then((value) {
      passwordModel = PasswordModel.fromJson(value.data);
      emit(SucessChangePasswordState(passwordModel));
    }).catchError((onError){
      emit(ErrorChangePasswordState());
      print(onError);
    });
  }

  AddressModel? addressModel;
  void getAddress()
  {
    emit(LoadingAddressDataState());

    DioHelper.getData(
      url: ADDRESSES,
      token: token,
    ).then((value) {
      addressModel = AddressModel.fromJson(value.data);
      addressModel!.data!.data!.forEach((element) {
        name.addAll({element!.id: element.name});
        city.addAll({element.id: element.city});
        region.addAll({element.id: element.region});
        details.addAll({element.id: element.details});
        notes.addAll({element.id: element.notes});
      });
      emit(SucessAddressDataState());
    }).catchError((onError) {
      emit(ErrorAddressDataState());
      print(onError.toString());
    });
  }
  AddressModel? addAddressvar;
  void addAddress({
  required String name,
    required String city,
    required String region,
    required String details,
    required String notes,

  })
  {
    emit(LoadingAddAddressDataState());
    DioHelper.postData(
        url: ADDRESSES,
        data: {
          'name':name,
          'city':city,
          'region':region,//latitude
          'details':details,
          'notes':notes,
          'latitude':'30.0616863',
          'longitude':'31.3260088',
        }, token: token).then((value) {
      addAddressvar = AddressModel.fromJson(value.data);
      if (addAddressvar!.status==true) {
        getAddress();
        emit(SucessAddAddressDataState(addAddressvar!.message));
      }
    }).catchError((error) {
      emit(ErrorAddAddressDataState());
      print(error);
    });
  }

  AddressModel? deleteAddressvar;
  void deleteAddress(addressId)
  {
    emit(LoadingDeleteAddressDataState());
    DioHelper.deleteData(
        url: '$ADDRESSES/$addressId', token: token).then((value) {
      deleteAddressvar = AddressModel.fromJson(value.data);
      if (deleteAddressvar!.status==true) {
        getAddress();
        emit(SucessDeleteAddressDataState(deleteAddressvar));
      }
    }).catchError((error) {
      emit(ErrorDeleteAddressDataState());
      print(error);
    });
  }

  AddressModel ? updateaddress;
  void updateAddress(
      {
        required int id,
        required String name,
        required String city,
        required String region,
        required String details,
        required String notes,
      }
      )
  {
    emit(LoadingUpdateAddressDataState());

    DioHelper.putData(
      url: '$ADDRESSES/$id',
      token: token,
      data:
      {
        'name':name,
        'city':city,
        'region':region,
        'details':details,
        'notes':notes,
        'latitude':'30.0616863',
        'longitude':'31.3260088',

      },
    ).then((value) {
      updateaddress = AddressModel.fromJson(value.data);
      emit(SucessUpdateAddressDataState(updateaddress));
      getAddress();
    }
    ).catchError((onError)
    {
      emit(ErrorUpdateProfileState());
      print(onError.toString());
    });
  }
}

