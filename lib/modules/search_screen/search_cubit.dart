import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/product_search.dart';
import 'package:shop_app/modules/search_screen/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/diohelper.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() : super(InitialState());
  static SearchCubit get(context) => BlocProvider.of(context);
  ProductSearch? searchModel;

  void search (String text) 
  {
    emit(LoadingState());
    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
          'text' : text
        }
    ).then((value)
    {
      searchModel = ProductSearch.fromJson(value.data);
      emit(SucessState());
    }).catchError((onError) {
      emit(ErrorState());
      print(onError);
    });
  }
}