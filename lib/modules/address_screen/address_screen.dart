import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layouts/cubit/cubit.dart';
import 'package:shop_app/layouts/cubit/states.dart';
import 'package:shop_app/models/address_model.dart';
import 'package:shop_app/modules/address_screen/add_address.dart';
import 'package:shop_app/modules/address_screen/edit_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class AddressScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeLayoutStates>(
      listener: (context,state) {
        if (state is SucessDeleteAddressDataState)
          showToastMessage(state.addressModel!.message.toString());
        if (state is ErrorDeleteAddressDataState)
          showToastMessage('Please check your internet');
      },
      builder: (context,state) => Scaffold(
        appBar: AppBar(
          title: Text('Shipping Address',style: TextStyle(
          ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (state is LoadingDeleteAddressDataState)
                LinearProgressIndicator(
                  backgroundColor: defaultColor.withOpacity(0.6),
                ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    navigateTo(context, AddAddressScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.add,color: HexColor('1A925D'),),
                        SizedBox(width: 7,),
                        Text('Add Address',style: TextStyle(fontSize: 20),),

                    ],),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: myDivider(0.6),
              ),
              SizedBox(height: 3,),

              BuildCondition(
                condition: HomeCubit.get(context).addressModel?.data?.data?.length!=null,
                builder: (context) =>
                    BuildCondition(
                      condition: HomeCubit.get(context).addressModel!.data!.data!.length != 0,
                      builder: (context) => ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index) => buildAddress(HomeCubit.get(context).addressModel!.data!.data![index],context,state),
                      separatorBuilder: (context,index) => SizedBox(height: 5,),
                      itemCount: HomeCubit.get(context).addressModel!.data!.data!.length),
                      fallback: (context) => Column(
                        children: [
                          SizedBox(height:250 ,),
                          Text('No address added',style: TextStyle(color: Colors.grey,fontSize: 20),),
                        ],
                      ),
                    ),
                fallback: (context) => SizedBox(
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildAddress(AddressModelDataData? model,context,state ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow:[BoxShadow(
                  color: Colors.grey.withOpacity(0.5),spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, 2),

                ),],
                borderRadius: BorderRadius.circular(20)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${model!.name}',
                          style: TextStyle(fontSize: 26,height: 1.25),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          navigateTo(context, EditAddressScreen(model.id));
                        },
                        child: Row(
                          children: [
                            Icon(Icons.edit_outlined,size: 21,color: Colors.grey.shade800),
                            Text('Edit',style: TextStyle(fontSize: 15,color: Colors.grey.shade800),),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Text('City',style: TextStyle(fontSize: 15,color: Colors.grey),),
                      SizedBox(width: 40,),
                      Text('${model.city}',),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text('Region',style: TextStyle(fontSize: 15,color: Colors.grey),),
                      SizedBox(width: 18,),
                      Text('${model.region}',),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text('Details',style: TextStyle(fontSize: 15,color: Colors.grey),),
                      SizedBox(width: 18,),
                      Text('${model.details}',),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text('Notes',style: TextStyle(fontSize: 15,color: Colors.grey),),
                      SizedBox(width: 24,),
                      Flexible(child: Text('${model.notes}',maxLines: 1,overflow: TextOverflow.ellipsis,)),
                    ],
                  ),
                  SizedBox(height: 25,),
                  Center(
                    child: InkWell(
                      onTap: () {
                        HomeCubit.get(context).deleteAddress(model.id);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.delete,color: Colors.red.shade800,),
                          Text('Delete',
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.red.shade800),
                          ),
                        ],
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
