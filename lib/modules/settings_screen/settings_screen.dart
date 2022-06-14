import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layouts/cubit/cubit.dart';
import 'package:shop_app/layouts/cubit/states.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/modules/Loginscreen/login_screen.dart';
import 'package:shop_app/modules/address_screen/address_screen.dart';
import 'package:shop_app/modules/settings_screen/faqs.dart';
import 'package:shop_app/modules/settings_screen/updateprofle_screen/updateprofile_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';
import 'package:shop_app/shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeLayoutStates>(
        listener: (context,state) {

        },
        builder: (context,state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                BuildCondition(
                  condition: HomeCubit.get(context).userModel != null,
                  builder: (context) => Container(
                      child: accSettings(context,HomeCubit.get(context).userModel!.data)),
                  fallback: (context) => Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CircularProgressIndicator(),
                  )
                ),
                Center(
                  child: Text('$accountName',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25,color: Colors.black54),),
                ),
                SizedBox(height: 70,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      navigateTo(context, UpdateProfile());
                    },
                    child: Container(
                      width: double.infinity,
                      height: 85,
                      color: Colors.black26.withOpacity(0.032),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0 , vertical: 2.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                                radius: 25,
                                child: Icon(Icons.person,size: 25,color: Colors.white,)),
                            SizedBox(width: 12,),
                            Text('Edit Profile',style: TextStyle(fontSize: 20),),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0 , vertical: 2.0),
                  child: InkWell(
                    onTap: () {
                      navigateTo(context, AddressScreen());
                    },
                    child: Container(
                      width: double.infinity,
                      height: 85,
                      color: Colors.black26.withOpacity(0.032),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0 , vertical: 2.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                backgroundColor: defaultColor,
                                radius: 25.0,
                                child: Icon(Icons.location_on,size: 20,color: Colors.white,)),
                            SizedBox(width: 12,),
                            Text('Addresses',style: TextStyle(fontSize: 20),),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      navigateTo(context, FaqsScreen());
                    },
                    child: Container(
                      width: double.infinity,
                      height: 85,
                      color: Colors.black26.withOpacity(0.035),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                backgroundColor: defaultColor,
                                radius: 25.0,
                                child: Icon(Icons.help_center,size: 20,color: Colors.white,)),
                            SizedBox(width: 12,),
                            Text('Help Center',style: TextStyle(fontSize: 20),),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0 , vertical: 2.0),
                  child: InkWell(
                    onTap: () {
                      CacheHelper.removeToken(key: 'token').then((value) {
                        navigateAndFinish(context, LoginScreen());
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: 85,
                      color: Colors.black26.withOpacity(0.032),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0 , vertical: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                backgroundColor: defaultColor,
                                radius: 25.0,
                                child: Icon(Icons.logout,size: 20,color: Colors.white,)),
                            SizedBox(width: 12,),
                            Text('Sign out',style: TextStyle(fontSize: 20),),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 70.0,vertical: 20.0),
                //   child: defaultButton(function: () {
                //     CacheHelper.removeToken(key: 'token').then((value) {
                //       navigateAndFinish(context, LoginScreen());
                //     });
                //
                //   }, text: 'Sign out',icon: Icons.logout,radius: 8),
                // )
              ],
            ),
          );
        }
    );
  }
  Widget accSettings(context,UserModelData? model)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height:7,),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 54.5,
                  backgroundColor: Colors.black26,
                ),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                      width: 105,
                        height: 105,
                        child: CircleAvatar(
                            backgroundColor: Colors.black,
                            backgroundImage: NetworkImage('$imageId'),)),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Icon(Icons.add_a_photo_sharp,
                        size: 25,
                        color: HexColor('5C5C5B'),),
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: InkWell(
        //     onTap: () {
        //       navigateTo(context, UpdateProfile());
        //     },
        //     child: Container(
        //       width: double.infinity,
        //       height: 100,
        //       color: Colors.black26.withOpacity(0.035),
        //         child: Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Row(
        //             children: [
        //               CircleAvatar(
        //                 radius: 25,
        //                   child: Icon(Icons.supervised_user_circle,size: 25,color: Colors.white,)),
        //               SizedBox(width: 12,),
        //               Text('Update Profile',style: TextStyle(fontSize: 20),),
        //               Spacer(),
        //               Icon(Icons.arrow_forward_ios),
        //             ],
        //           ),
        //         ),
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: InkWell(
        //     onTap: () {
        //       navigateTo(context, FaqsScreen());
        //     },
        //     child: Container(
        //       width: double.infinity,
        //       height: 100,
        //       color: Colors.black26.withOpacity(0.035),
        //       child: Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Row(
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             CircleAvatar(
        //               backgroundColor: defaultColor,
        //                 radius: 25.0,
        //                 child: Icon(Icons.message,size: 20,color: Colors.white,)),
        //             SizedBox(width: 12,),
        //             Text('FAQs',style: TextStyle(fontSize: 20),),
        //             Spacer(),
        //             Icon(Icons.arrow_forward_ios),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(70.0),
        //   child: defaultButton(function: () {}, text: 'Logout',icon: Icons.logout),
        // )
      ],
    );
  }
}