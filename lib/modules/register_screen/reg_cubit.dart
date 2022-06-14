import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/register_screen/reg_states.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/diohelper.dart';

class RegisterCubit extends Cubit<ShopRegisterStates> {
  RegisterCubit() : super(RegisterInitialStates());
  static RegisterCubit get(context) => BlocProvider.of(context);
  bool isShownPass = false;
  bool isShownConfirm = false;
  late LoginModel registerModel;

  void userRegister ({
    required String email,
    required String password,
    required String name,
    required String phone,
  })
  {
    emit(RegisterLoadingStates());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'email':email,
          'password':password,
          'name':name,
          'phone':phone,
        }).then((value) {
      registerModel = LoginModel.fromJson(value.data);
      print('${registerModel.message}');
      emit(RegisterSucessStates(registerModel));
    }).catchError((onError) {
      emit(RegisterErrorStates(onError.toString()));
      print(onError);
    });
  }

  void changePasswordSecure()
  {
    isShownPass = !isShownPass;
    emit(SuffixPressed());
  }

  void changeConfirmPassSecure()
  {
    isShownConfirm = !isShownConfirm;
    emit(SuffixPressed());
  }

}