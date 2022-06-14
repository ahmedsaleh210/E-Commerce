import 'package:shop_app/models/address_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/incarts_model.dart';
import 'package:shop_app/models/password_model.dart';
import 'package:shop_app/models/update_profile.dart';

abstract class HomeLayoutStates {}


class HomeInitialState extends HomeLayoutStates {}

class ChangeScreen extends HomeLayoutStates {}

class LoadingHomeDataState extends HomeLayoutStates {}

class SucessHomeDataState extends HomeLayoutStates {}

class ErrorHomeDataState extends HomeLayoutStates {}

class SucessCategoriesDataState extends HomeLayoutStates {}

class LoadingCategoryProducts extends HomeLayoutStates {}

class ErrorCategoryProducts extends HomeLayoutStates {}

class SucessCategoryProducts extends HomeLayoutStates {}

class ErrorCategoriesDataState extends HomeLayoutStates {}

///////favorites///////
class SucessFavoritesDataState extends HomeLayoutStates {
  final FavoritesModel ? model;
  SucessFavoritesDataState(this.model);
}

class LoadingFavoritesDataState extends HomeLayoutStates {}

class ErrorFavoritesDataState extends HomeLayoutStates {}

class SucessFavoritesScreenDataState extends HomeLayoutStates {}

class LoadingFavoritesScreenDataState extends HomeLayoutStates {}

class ErrorFavoritesScreenDataState extends HomeLayoutStates {}

////////carts///////
class LoadingCartsDataState extends HomeLayoutStates {}

class ErrorCartsDataState extends HomeLayoutStates {}

class SucessCartsDataState extends HomeLayoutStates {
  final InCartsModel? inCartsModel;
  SucessCartsDataState(this.inCartsModel);
}

class SucessUpdateCartsDataState extends HomeLayoutStates {}

class ErrorUpdateCartsDataState extends HomeLayoutStates {}

class LoadingUpdateCartsDataState extends HomeLayoutStates {}

class SucessCartsScreenDataState extends HomeLayoutStates {}

class LoadingCartsScreenDataState extends HomeLayoutStates {}

class ErrorCartsScreenDataState extends HomeLayoutStates {}

class LoadingProductDataState extends HomeLayoutStates {}

class SucessProductDataState extends HomeLayoutStates {}

class ErrorProductDataState extends HomeLayoutStates {}

class LoadingUserDataState extends HomeLayoutStates {}

class SucessUserDataState extends HomeLayoutStates {}

class ErrorUserDataState extends HomeLayoutStates {}

class LoadingFaqsDataState extends HomeLayoutStates {}

class SucessFaqsDataState extends HomeLayoutStates {}

class ErrorFaqsDataState extends HomeLayoutStates {}

class LoadingUpdateProfileState extends HomeLayoutStates {}

class SucessUpdateProfileState extends HomeLayoutStates {
  final UpdateProfile? msg;
  SucessUpdateProfileState(this.msg);
}

class SucessUpdateNameState extends HomeLayoutStates {
}


class ErrorUpdateProfileState extends HomeLayoutStates {}

class LoadingChangePasswordState extends HomeLayoutStates {}

class SucessChangePasswordState extends HomeLayoutStates {
  final PasswordModel? passowrdModel;
  SucessChangePasswordState(this.passowrdModel);
}


class ErrorChangePasswordState extends HomeLayoutStates {}

class LoadingAddressDataState extends HomeLayoutStates {}

class SucessAddressDataState extends HomeLayoutStates {}

class ErrorAddressDataState extends HomeLayoutStates {}

class ErrorAddAddressDataState extends HomeLayoutStates {}

class SucessAddAddressDataState extends HomeLayoutStates {
  final String? msg;
  SucessAddAddressDataState(this.msg);
}

class LoadingAddAddressDataState extends HomeLayoutStates {}

class ErrorDeleteAddressDataState extends HomeLayoutStates {}

class SucessDeleteAddressDataState extends HomeLayoutStates {
  final AddressModel? addressModel;
  SucessDeleteAddressDataState(this.addressModel);
}

class LoadingDeleteAddressDataState extends HomeLayoutStates {}

class ErrorUpdateAddressDataState extends HomeLayoutStates {}

class SucessUpdateAddressDataState extends HomeLayoutStates {
  final AddressModel? addressModel;
  SucessUpdateAddressDataState(this.addressModel);
}

class LoadingUpdateAddressDataState extends HomeLayoutStates {}


