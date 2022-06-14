import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layouts/cubit/cubit.dart';
import 'package:shop_app/layouts/cubit/states.dart';
import 'package:shop_app/models/incarts_model.dart';
import 'package:shop_app/modules/product_screen/products_details.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class CartsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeLayoutStates>(
        listener: (context,state) {
          if (state is SucessCartsDataState)
            showToastMessage('${state.inCartsModel!.message}');
        },
        builder: (context,state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('My Cart'),
            ),

            bottomNavigationBar: HomeCubit.get(context).inCartsModel?.data?.cartItems != null ?
            BottomAppBar(
              color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    if (HomeCubit.get(context).inCartsModel?.data?.cartItems != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Total Price:',
                              style:TextStyle(
                                  color:Colors.black54,
                                  fontSize: 17,
                                height: 1,
                              ) ,),
                            Text('${HomeCubit.get(context).inCartsModel!.data!.total} EGP',
                              style:TextStyle(
                                  color: HexColor('10BD70'),
                                  fontSize: 18,
                                height: 1.5,
                              ) ,),
                          ],
                        ),
                      ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: defaultColor,
                              boxShadow: [BoxShadow(
                                color: Colors.grey.withOpacity(0.5),spreadRadius: 0.5,
                                blurRadius: 2,
                                offset: Offset(0, 2),

                              ),]
                          ),
                          child: MaterialButton(
                            onPressed: () {},
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child:    Text(
                              'Checkout',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
            ),
                  ),
            ):null,

            // floatingActionButton: Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child: FloatingActionButton(onPressed: () {  },
            //     child: Icon(Icons.shopping_cart),
            //     backgroundColor: Colors.redAccent,
            //   ),
            // ),
            body: Container(
                height: double.infinity,
                child: BuildCondition(
                  condition: HomeCubit.get(context).inCartsModel?.data?.cartItems != null,
                  builder: (context) =>
                      BuildCondition(
                        condition: HomeCubit.get(context).inCartsModel!.data!.total != 0,
                        builder: (context) => cartsList(HomeCubit.get(context).inCartsModel,state),
                        fallback: (context) => Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  width: 200,
                                  height: 150,
                                  child: SvgPicture.asset('assets/images/login.svg',),
                                ),
                              ),
                              Text('Your cart is empty',style: TextStyle(fontSize: 25),),
                            ],
                          ),
                        ),

                      ),
                  fallback: (context) {
                    return Center(
                      child: Column(

                        children: [
                          LinearProgressIndicator(
                            backgroundColor: defaultColor.withOpacity(0.6),
                          ),
                        ],
                      ),
                    );
                  } ,)
            ),
          );
        }
    );
  }

  Widget cartsList(InCartsModel? inCartsModel,state)
  {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (state is LoadingUpdateCartsDataState || state is LoadingCartsScreenDataState)
          LinearProgressIndicator
            (
            backgroundColor: defaultColor.withOpacity(0.6),
          ),
          Container(
            child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index) => cartsBuilder(HomeCubit.get(context).inCartsModel!.data!.cartItems![index],context),
                separatorBuilder:(context,index) => SizedBox(height: 2,),
                itemCount: inCartsModel!.data!.cartItems!.length),
          ),
          SizedBox(height: 5,),

        ],
      ),
    );
  }

  Widget cartsBuilder(InCartsModelDataCartItems? model,context) => Padding(
    padding: const EdgeInsets.all(5.0),
    child: Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      elevation: 1,

      child: InkWell(
        onTap: (){
          HomeCubit.get(context).getProductData(model!.product!.id);
          navigateTo(context, ProductDetailsScreen(model.product!.id));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Container(
                        width: 100.0,
                        height: 100.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            image: NetworkImage('${model!.product!.image}'),
                          ),
                        ),
                      ),
                      if (model.product!.discount!.round()!=0)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0,),
                            child: Text('Discount ${model.product!.discount!.round()}%',
                              style: TextStyle(
                                color: Colors.white,
                              ),),
                          ),
                        ),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(onPressed: () {
                        int quantity = model.quantity!.toInt();
                        HomeCubit.get(context).updateCarts(model.id,++quantity);
                      },

                          child: Text('+',style: TextStyle(fontSize: 25),)),
                      Text('${model.quantity}'),
                      TextButton(onPressed: () {
                        int quantity = model.quantity!.toInt();
                        if (quantity>1)
                          HomeCubit.get(context).updateCarts(model.id,--quantity);
                        else
                          HomeCubit.get(context).changeCarts(model.product!.id);
                      }, child: Text('-',style: TextStyle(fontSize: 25,color: Colors.red),)),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 20,),
              Expanded(
                child: Container(
                  height: 150.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '${model.product!.name}',
                          maxLines:2 ,
                          overflow: TextOverflow.ellipsis ,
                          style: TextStyle(
                              fontSize: 15
                          ),
                        ),
                      ),

                      Row(
                        children: [
                          Text('Shipping Price: ',style: TextStyle(
                              fontSize: 14
                          ),),
                          Text('Free',style: TextStyle(color: defaultColor,fontSize: 14),),

                        ],
                      ),
                      SizedBox(height: 5,),


                      Row(
                        children: [
                          Row(
                            children: [
                              Text('Price: ',style: TextStyle(
                                  fontSize: 14
                              ),
                              ),
                              Text('${(model.product!.price!.toInt())*(model.quantity!.toInt())} EGP',

                                maxLines:2 ,
                                overflow: TextOverflow.ellipsis ,
                                style: TextStyle(
                                    color: defaultColor,
                                    fontSize: 14
                                ),
                              ),
                              SizedBox(width: 5,),

                            ],
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                // IconButton(
                                //   icon: Icon(
                                //     Icons.delete_outline_outlined,//7D0522
                                //     color: HexColor('4C4E4D'),
                                //
                                //   ), onPressed: () { HomeCubit.get(context).changeCarts(model.product!.id); },
                                InkWell(
                                  onTap: () {
                                    if (HomeCubit.get(context).inCartsRealTime[model.product!.id] == true)
                                      HomeCubit.get(context).changeCarts(model.product!.id);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete_outline_outlined,color:Colors.black54,),
                                      Text('Remove',style: TextStyle(color: Colors.black54,fontSize: 16),)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
