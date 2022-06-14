import 'package:shop_app/models/login_model.dart';

abstract class ShopLoginStates { }

class LoginInitialStates extends ShopLoginStates { }

class LoginLoadingStates extends ShopLoginStates { }


class LoginSucessStates extends ShopLoginStates {
  final LoginModel loginModel;
  LoginSucessStates(this.loginModel);
}

class LoginErrorStates extends ShopLoginStates {
  final String error;
  LoginErrorStates(this.error);
}


class SuffixPressed extends ShopLoginStates { }