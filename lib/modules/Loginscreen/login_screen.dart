import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/layouts/cubit/cubit.dart';
import 'package:shop_app/layouts/home_layout.dart';
import 'package:shop_app/modules/Loginscreen/logincubit.dart';
import 'package:shop_app/modules/Loginscreen/states.dart';
import 'package:shop_app/modules/register_screen/reg_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  final emailcontroller = TextEditingController();
  final passwordconroller= TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,ShopLoginStates>(
        listener: (context,state) {
          var cubit = HomeCubit.get(context);
          if (state is LoginSucessStates) {
            if(state.loginModel.status)
              {
                showToastMessage(state.loginModel.message);
                CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token).then((value) {
                  token = CacheHelper.getData(key: 'token');
                  CacheHelper.saveData(key: 'name', value: state.loginModel.data?.name).then((value) => accountName = CacheHelper.getData(key: 'name'));
                  CacheHelper.saveData(key: 'imageId', value: state.loginModel.data?.image).then((value) => imageId = CacheHelper.getData(key: 'imageId'));
                  cubit.getCarts();
                  cubit.getFavorites();
                  cubit.getUserData();
                  cubit.getAddress();
                  cubit.currentIndex = 0;
                  navigateAndFinish(context, HomeLayout());
                  print(token);
                });
              }
            else {
              showToastMessage(state.loginModel.message);
            }
          }
        },
        builder: (context,state) {
          var cubit = LoginCubit.get(context);
          return  SafeArea(
            child: Scaffold(
                body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 10,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.87),
                            boxShadow: [BoxShadow(
                              color: Colors.grey.withOpacity(0.5),spreadRadius: 1,
                              blurRadius: 4,
                              offset: Offset(0, 2),

                            ),],
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 200,
                                      height: 150,
                                      child: SvgPicture.asset('assets/images/login.svg',),
                                    ),
                                    SizedBox(height: 7,),
                                    // Text('Login',
                                    // style: TextStyle(
                                    //   fontSize: 40,
                                    //
                                    // ),),
                                    Text('Login into your existance account',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey
                                      ),),
                                    SizedBox(height:20.0,)
                                  ],
                                ),
                              ),
                              Center(
                                child: Form(
                                  key: formkey,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                    child: Column(
                                      children: [
                                        defaultformfield(
                                          controller: emailcontroller,
                                          type: TextInputType.emailAddress,

                                          label: 'Email Address',
                                          prefix: Icons.email_outlined,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Email is empty';
                                            }
                                            return null;
                                          }
                                        ),
                                        SizedBox(height:5,),
                                        defaultformfield(
                                          controller: passwordconroller,
                                          type: TextInputType.visiblePassword,
                                          secure: cubit.isShown?false:true,
                                          label: 'Password',
                                          suffix: cubit.isShown?Icons.visibility:Icons.visibility_off,
                                          prefix: Icons.lock_outline,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Password is empty';
                                            }
                                            return null;
                                          },
                                          onSupmited: (value) {
                                            if (formkey.currentState!.validate())
                                            {
                                              cubit.userLogin(
                                                  email: emailcontroller.text,
                                                  password: passwordconroller.text);
                                            }
                                          },
                                          onSuffixPress: () {
                                            cubit.changePasswordSecure();
                                          }
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5.0),
                                child: Row(
                                  children: [
                                    Spacer(),
                                    TextButton(onPressed: (){}, child: Text('Forget Password?',style: TextStyle(fontSize: 15),)),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  BuildCondition(
                                    condition: state is !LoginLoadingStates,
                                    builder: (context) => Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                                      child: defaultButton(function: () {
                                        if (formkey.currentState!.validate())
                                          {
                                            cubit.userLogin(
                                                email: emailcontroller.text,
                                                password: passwordconroller.text);
                                          }
                                      },
                                        text: 'Sign In',
                                        height: 50,
                                      ),
                                    ) ,
                                    fallback: (context) => Center(child: CircularProgressIndicator(
                                      strokeWidth: 7,
                                    )),
                                  ),
                                  SizedBox(height: 30,),
                                  myDivider(3),
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('Don\'t have an account?',
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      TextButton(onPressed: () {
                                        navigateTo(context, RegisterScreen());
                                      }, child: Text(''
                                          'Sign Up',
                                        style: TextStyle(
                                          fontSize: 17,

                                        ),
                                      ),
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: Text('Or Quick Access',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SignInButton(
                                        Buttons.FacebookNew,
                                        text: 'Connect With Facebook',
                                        onPressed: () {},
                                      ),

                                      SizedBox(height: 4,),
                                      SignInButton(
                                        Buttons.Google,
                                        text: 'Connect With Google',
                                        onPressed: () {},
                                      ),
                                      SizedBox(height: 20,),
                                    ],
                                  ),
                                  // ClipOval(
                                  //   child: Material(
                                  //     child: InkWell(
                                  //       onTap: () {},
                                  //       child: Container(
                                  //         width: 60,
                                  //         child: Image(
                                  //           image:AssetImage('assets/images/facebook.png',),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // ClipOval(
                                  //
                                  //   child: InkWell(
                                  //     onTap: () {},
                                  //     child: Container(
                                  //       width: 60,
                                  //       child: Image(
                                  //         image:AssetImage('assets/images/google.png',),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            ),
          );
        },
      ),
    );
  }
}
