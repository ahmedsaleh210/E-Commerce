import 'package:shop_app/models/login_model.dart';

abstract class ShopRegisterStates { }

class RegisterInitialStates extends ShopRegisterStates { }

class RegisterLoadingStates extends ShopRegisterStates { }


class RegisterSucessStates extends ShopRegisterStates {
  final LoginModel registerModel;
  RegisterSucessStates(this.registerModel);
}

class RegisterErrorStates extends ShopRegisterStates {
  final String error;
  RegisterErrorStates(this.error);
}


class SuffixPressed extends ShopRegisterStates { }