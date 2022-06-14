import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/Loginscreen/states.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/diohelper.dart';

class LoginCubit extends Cubit<ShopLoginStates> {
  LoginCubit() : super(LoginInitialStates());
  static LoginCubit get(context) => BlocProvider.of(context);
  bool isShown = false;
  late LoginModel loginModel;

      void userLogin ({
  required String email,
  required String password,
})
    {
      emit(LoginLoadingStates());
      DioHelper.postData(
          url: LOGIN,
          data: {
            'email':email,
            'password':password,
      }).then((value) {
        loginModel = LoginModel.fromJson(value.data);
        emit(LoginSucessStates(loginModel));
      }).catchError((onError) {
        emit(LoginErrorStates(onError.toString()));
        print(onError);
      });
    }

    void changePasswordSecure()
    {
      isShown = !isShown;
      emit(SuffixPressed());
    }

}