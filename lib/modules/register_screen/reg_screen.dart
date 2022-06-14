import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/cubit/cubit.dart';
import 'package:shop_app/layouts/home_layout.dart';
import 'package:shop_app/modules/Loginscreen/login_screen.dart';
import 'package:shop_app/modules/register_screen/reg_cubit.dart';
import 'package:shop_app/modules/register_screen/reg_states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';

class RegisterScreen extends StatelessWidget {
  final registerFormKey = GlobalKey<FormState>();
  final registerScaffoldKey = GlobalKey<ScaffoldState>();
  final registerEmailcontroller = TextEditingController();
  final registerPasswordcontroller = TextEditingController();
  final passwordConfirmcontroller = TextEditingController();
  final nameOfUsercontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,ShopRegisterStates>(
        listener: (context,state)
        {
          var cubit = HomeCubit.get(context);
          if (state is RegisterSucessStates) {
            if(state.registerModel.status)
            {
              showToastMessage(state.registerModel.message);
              CacheHelper.saveData(key: 'token', value: state.registerModel.data?.token).then((value) {
                token = CacheHelper.getData(key: 'token');
                CacheHelper.saveData(key: 'name', value: state.registerModel.data?.name).then((value) => accountName = CacheHelper.getData(key: 'name'));
                CacheHelper.saveData(key: 'imageId', value: state.registerModel.data?.image).then((value) => imageId = CacheHelper.getData(key: 'imageId'));
                cubit.getCarts();
                cubit.getFavorites();
                cubit.getUserData();
                navigateAndFinish(context, HomeLayout());
                print(token);
              });
            }
            else {
              showToastMessage(state.registerModel.message);
            }
          }
        } ,
        builder: (context,state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
              appBar: AppBar(
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 10,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey.withOpacity(0.1),
                            spreadRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text('Sign up',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.black45,
                                shadows: [
                                  Shadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    offset: Offset(2, 2),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                            Form(
                              key: registerFormKey,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Column(
                                  children: [
                                    defaultformfield(
                                        controller: nameOfUsercontroller,
                                        type: TextInputType.text,

                                        label: 'Name',
                                        prefix: Icons.person,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Name is empty';
                                          }
                                          return null;
                                        }
                                    ),
                                    SizedBox(height:5,),
                                    defaultformfield(
                                        controller: registerEmailcontroller,
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
                                        controller: phonecontroller,
                                        type: TextInputType.phone,
                                        label: 'Phone Number',
                                        prefix: Icons.phone,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Phone Number is empty';
                                          }
                                          return null;
                                        }
                                    ),
                                    defaultformfield(
                                        controller: registerPasswordcontroller,
                                        type: TextInputType.visiblePassword,
                                        secure: cubit.isShownPass?false:true,
                                        label: 'Password',
                                        suffix: cubit.isShownPass?Icons.visibility:Icons.visibility_off,
                                        prefix: Icons.lock_outline,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Password is empty';
                                          }
                                          else if (value != passwordConfirmcontroller.text)
                                          {
                                            return ('Does not match confirm password');
                                          }
                                          return null;
                                        },
                                        onSuffixPress: ()
                                        {
                                          cubit.changePasswordSecure();
                                        }
                                    ),
                                    defaultformfield(
                                        controller: passwordConfirmcontroller,
                                        type: TextInputType.visiblePassword,
                                        secure: cubit.isShownConfirm?false:true,
                                        label: 'Confirm Password',
                                        suffix: cubit.isShownConfirm?Icons.visibility:Icons.visibility_off,
                                        prefix: Icons.lock_outline,
                                        validator: (value) {
                                          if (value!.isEmpty)
                                          {
                                            return 'Confirm Password is empty';
                                          }
                                          else if (value != registerPasswordcontroller.text)
                                          {
                                            return ('Does not match password');
                                          }
                                          return null;
                                        },
                                        onSupmited: (value) {
                                          if (registerFormKey.currentState!.validate())
                                          {
                                          }
                                        },
                                        onSuffixPress: ()
                                        {
                                          cubit.changeConfirmPassSecure();
                                        }
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            BuildCondition(
                              condition: state is !RegisterLoadingStates,
                              builder: (context) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 35,
                                  vertical: 10,
                                ),
                                child: defaultButton(
                                    function: () {
                                      if (registerFormKey.currentState!.validate())
                                      {
                                        cubit.userRegister(
                                            email: registerEmailcontroller.text,
                                            password: registerPasswordcontroller.text,
                                            name: nameOfUsercontroller.text,
                                            phone: phonecontroller.text);
                                      }
                                    },
                                    text: 'Create'),
                              ),
                              fallback: (context) => Center(child: CircularProgressIndicator(),),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Already have an account?',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),),
                                TextButton(
                                  onPressed: () {
                                    navigateTo(context, LoginScreen());
                                  },
                                  child: Text('Sign In',
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),

                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
          );
        }
      ),
    );
  }
}
