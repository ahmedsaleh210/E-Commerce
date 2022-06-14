import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/cubit/cubit.dart';
import 'package:shop_app/layouts/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class EditAddressScreen extends StatelessWidget {
  final addressId;
  EditAddressScreen(this.addressId);
  final addressKey =  GlobalKey<FormState>();
  final nameAddress = TextEditingController();
  final cityAddress = TextEditingController();
  final regionAddress = TextEditingController();
  final detailsAddress = TextEditingController();
  final notesAddress = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeLayoutStates>(
      listener: (context,state)
      {
        if (state is SucessUpdateAddressDataState)
          showToastMessage(state.addressModel!.message.toString());
      } ,
      builder: (context,state) {
        var cubit = HomeCubit.get(context);
        nameAddress.text=cubit.name[addressId];
        cityAddress.text=cubit.city[addressId];
        regionAddress.text=cubit.region[addressId];
        detailsAddress.text=cubit.details[addressId];
        notesAddress.text=cubit.details[addressId];
        return Scaffold(
            appBar: AppBar(
              title: Center(child: Text('Edit Address')),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is LoadingUpdateAddressDataState || state is LoadingAddressDataState )
                    LinearProgressIndicator(
                      backgroundColor: defaultColor.withOpacity(0.6),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 15,
                    ),
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            // Text('Add New Address',
                            //   style: TextStyle(
                            //     fontSize: 30,
                            //     color: Colors.black45,
                            //     shadows: [
                            //       Shadow(
                            //         color: Colors.grey.withOpacity(0.2),
                            //         offset: Offset(2, 2),
                            //         blurRadius: 2,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Form(
                              key: addressKey,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Column(
                                  children: [
                                    defaultformfield(
                                        controller: nameAddress,
                                        type: TextInputType.text,
                                        prefix: Icons.home_work,

                                        label: 'Location Name',
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Name is empty';
                                          }
                                          return null;
                                        }
                                    ),
                                    SizedBox(height:5,),
                                    defaultformfield(
                                        controller: cityAddress,
                                        type: TextInputType.text,
                                        prefix: Icons.map,
                                        label: 'City Name',
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'City field is empty';
                                          }
                                          return null;
                                        }
                                    ),
                                    SizedBox(height:5,),
                                    defaultformfield(
                                        controller: regionAddress,
                                        type: TextInputType.text,
                                        prefix: Icons.location_on,
                                        label: 'Region',
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Region field is empty';
                                          }
                                          return null;
                                        }
                                    ),
                                    SizedBox(height:5,),
                                    defaultformfield(
                                        controller: detailsAddress,
                                        type: TextInputType.text,
                                        prefix: Icons.article,
                                        label: 'Details',
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Details field is empty';
                                          }
                                          return null;
                                        },
                                        onSuffixPress: ()
                                        {
                                        }
                                    ),
                                    defaultformfield(
                                        controller: notesAddress,
                                        prefix: Icons.notes,
                                        type: TextInputType.text,
                                        label: 'Some notes to help find you',
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Notes field is empty';
                                          }
                                          return null;
                                        },
                                        onSuffixPress: ()
                                        {
                                        }
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            BuildCondition(
                              condition: state is !LoadingAddAddressDataState,
                              builder: (context) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 35,
                                  vertical: 10,
                                ),
                                child: defaultButton(
                                    function: () {
                                      if (addressKey.currentState!.validate())
                                      {
                                        HomeCubit.get(context).updateAddress(
                                          id: addressId,
                                          name: nameAddress.text,
                                          city: cityAddress.text,
                                          region: regionAddress.text,
                                          details: detailsAddress.text,
                                          notes: notesAddress.text,
                                        );
                                      }

                                    },
                                    text: 'Submit'),
                              ),
                              fallback: (context) => Center(child: CircularProgressIndicator(),),
                            ),
                            SizedBox(height: 15,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
        );
      }
    );
  }
}
