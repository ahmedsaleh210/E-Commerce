import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/cubit/cubit.dart';
import 'package:shop_app/layouts/cubit/states.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class UpdatePassword extends StatelessWidget {
  final passwordFormKey = GlobalKey<FormState>();
  final updateScaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeLayoutStates>(
        listener: (context,state) {
          if (state is SucessChangePasswordState)
          {
            showToastMessage(state.passowrdModel!.message);
          }
        },
        builder: (context,state) {
          return Scaffold(
            key: updateScaffoldKey,
            appBar: AppBar(
              title: Text('Change Password'),
            ),
            body: Container(
                child: BuildCondition(
                  condition: HomeCubit.get(context).userModel != null ,
                  builder: (context) => changePassword(context,HomeCubit.get(context).userModel!.data,state),
                  fallback: (context) => Center(child: RefreshProgressIndicator()) ,
                )),
          );
        }
    );
  }
  Widget changePassword(context,UserModelData? model,state)
  {
    final oldPassword = TextEditingController();
    final newPassword = TextEditingController();
    final newPasswordConfirm = TextEditingController();

    return SingleChildScrollView(
      child: Form(
        key: passwordFormKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(
                  color: Colors.grey.withOpacity(0.5),spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, 2),

                ),],
                borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              children: [
                if (state is LoadingChangePasswordState)
                  LinearProgressIndicator(
                    backgroundColor: defaultColor.withOpacity(0.6),
                  ),

                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: defaultformfield(
                      validator: (value) {
                        if (value!.isEmpty)
                        {
                          return 'Old password is empty';
                        }
                        return null;
                      },
                      secure: true,
                      controller: oldPassword,
                      type: TextInputType.visiblePassword,
                      label: 'Current Password',
                      prefix: Icons.lock),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: defaultformfield(
                      validator: (value) {
                        if (value!.isEmpty)
                        {
                          return 'New password is empty';
                        }
                       else if (value!=newPasswordConfirm.text)
                        {
                          return 'does not match';
                        }
                        return null;
                      },
                      secure: true,
                      controller: newPassword,
                      type: TextInputType.visiblePassword,
                      label: 'New Password',
                      prefix: Icons.lock),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: defaultformfield(
                      validator: (value) {
                        if (value!.isEmpty)
                        {
                          return 'New password is empty';
                        }
                        else if (value!=newPassword.text)
                        {
                          return 'does not match';
                        }
                        return null;
                      },
                      secure: true,
                      controller: newPasswordConfirm,
                      type: TextInputType.visiblePassword,
                      label: 'Confirm New Password',
                      prefix: Icons.lock),
                ),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0,vertical: 10.0),
                  child: Column(
                    children: [
                      SizedBox(height: 15,),
                      BuildCondition(
                        condition: state is !LoadingChangePasswordState,
                        builder: (context) => defaultButton(
                            radius: 5,
                            function: () {
                              if (passwordFormKey.currentState!.validate())
                                {
                                  HomeCubit.get(context).changePassword(
                                      oldPassword: oldPassword.text,
                                      newPassword: newPassword.text
                                  );
                                }
                            },
                            text: 'Submit'),
                        fallback: (context) => defaultButton(
                            background: Colors.grey.withOpacity(0.5),
                            radius: 5,
                            function: () {
                            },
                            text: 'Wait for second..'),
                      ),
                      SizedBox(height: 15,)
                    ],
                  ),
                ),




              ],
            ),
          ),
        ),
      ),
    );
  }
}