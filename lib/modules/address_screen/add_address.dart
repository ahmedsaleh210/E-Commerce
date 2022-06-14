import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/cubit/cubit.dart';
import 'package:shop_app/layouts/cubit/states.dart';
import 'package:shop_app/modules/address_screen/address_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class AddAddressScreen extends StatelessWidget {
  final addressKey =  GlobalKey<FormState>();
  final nameAddress = TextEditingController();
  final cityAddress = TextEditingController();
  final regionAddress = TextEditingController();
  final detailsAddress = TextEditingController();
  final notesAddress = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeLayoutStates>(
      listener: (context,state) {
        if (state is SucessAddAddressDataState)
          showToastMessage(state.msg.toString());
        if (state is SucessAddAddressDataState)
          navigateTo(context, AddressScreen());
        if (state is ErrorAddAddressDataState)
          showToastMessage('Please check your internet');
      } ,
      builder: (context,state) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Add New Address')),
          ),
          body: SingleChildScrollView(
            child: Padding(
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

                                  label: 'Name',
                                  prefix: Icons.home_work,
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

                                  label: 'City',
                                  prefix: Icons.map,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'city field is empty';
                                    }
                                    return null;
                                  }
                              ),
                              SizedBox(height:5,),
                              defaultformfield(
                                  controller: regionAddress,
                                  type: TextInputType.text,
                                  label: 'Region',
                                  prefix: Icons.location_on,
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
                                  label: 'Details',
                                  prefix: Icons.article,
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
                                  type: TextInputType.text,
                                  label: 'Notes',
                                  prefix: Icons.notes,
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
                                 HomeCubit.get(context).addAddress(
                                     name: nameAddress.text,
                                     city: cityAddress.text,
                                     region: regionAddress.text,
                                     details: detailsAddress.text,
                                   notes: notesAddress.text,
                                 );
                                }
                              },
                              text: 'Add'),
                        ),
                        fallback: (context) => Center(child: CircularProgressIndicator(),),
                      ),
                      SizedBox(height: 15,),
                    ],
                  ),
                ),
              ),
            ),
          )
      ),
    );
  }
}
