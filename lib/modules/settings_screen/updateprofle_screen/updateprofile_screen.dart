import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/cubit/cubit.dart';
import 'package:shop_app/layouts/cubit/states.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/modules/settings_screen/updateprofle_screen/change_password.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class UpdateProfile extends StatelessWidget {
  final updateFormKey = GlobalKey<FormState>();
  final updateScaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeLayoutStates>(
        listener: (context,state) {
          if (state is SucessUpdateProfileState)
          {
            showToastMessage(state.msg!.message);
          }
        },
        builder: (context,state) {
          return Scaffold(

            key: updateScaffoldKey,
            appBar: AppBar(
              title: Text('Edit Profile'),
            ),
            body: BuildCondition(
              condition: HomeCubit.get(context).userModel != null ,
              builder: (context) => Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (state is LoadingUpdateProfileState)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: LinearProgressIndicator(
                              backgroundColor: defaultColor.withOpacity(0.6),
                            ),
                          ),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                                ],
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child:
                            accSettings(context,HomeCubit.get(context).userModel?.data,state),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );
        }
    );
  }
  Widget accSettings(context,UserModelData? model,state)
  {
    var accNameController = TextEditingController(text: model!.name);
    var accEmailController = TextEditingController(text: model.email);
    var accPhoneController = TextEditingController(text: model.phone);

    return Form(
      key: updateFormKey,
      child: Column(
        children: [

          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: defaultformfield(
              validator: (value) {
                if (value!.isEmpty)
                {
                  return 'Name is empty';
                }
                return null;
              },
                controller: accNameController,
                type: TextInputType.text,
                label: 'Account Name',
                prefix: Icons.account_circle),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: defaultformfield(
                validator: (value) {
                  if (value!.isEmpty)
                  {
                    return 'Email is empty';
                  }
                  return null;
                },
                controller: accEmailController,
                type: TextInputType.emailAddress,
                label: 'Email Address',
                prefix: Icons.email),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: defaultformfield(
                validator: (value) {
                  if (value!.isEmpty)
                  {
                    return 'Phone Number is empty';
                  }
                  return null;
                },
                controller: accPhoneController,
                type: TextInputType.phone,
                label: 'Phone Number',
                prefix: Icons.phone),
          ),


       Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0,vertical: 30.0),
              child: Column(
                children: [
                  defaultButton(
                      function: () {
                    if(updateFormKey.currentState!.validate())
                    {
                      HomeCubit.get(context).updateProfile(
                          name: accNameController.text,
                          email: accEmailController.text,
                          phone: accPhoneController.text,
                      );
                    }
                  }, text: 'Submit',radius: 5),
                  SizedBox(height: 15,),
                  defaultButton(
                      background: Colors.grey.withOpacity(0.5),
                      radius: 5,
                      function: () {
                        navigateTo(context, UpdatePassword());

                  },
                      text: 'Change Password'),
                ],
              ),
            ),




        ],
      ),
    );
  }
}