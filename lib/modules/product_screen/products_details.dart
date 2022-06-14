import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layouts/cubit/cubit.dart';
import 'package:shop_app/layouts/cubit/states.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/modules/cart_screen/cart_screen.dart';
import 'package:shop_app/modules/search_screen/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsScreen extends StatelessWidget {

  final productId;

  ProductDetailsScreen(this.productId){
    print(productId);
  }

  List<NetworkImage> images = [];
  var productImages = PageController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeLayoutStates>(
        listener: (context,state) {} ,
        builder: (context,state)
        {

          return Scaffold(
            backgroundColor: Colors.white,
            appBar:AppBar(
              title: Text('Shop App'),
              actions: [
                Center(
                  child: IconButton(
                    onPressed: () {
                      navigateTo(context, SearchScreen());
                    },
                    icon: Icon(
                      Icons.search,
                      size:32,
                      color: Colors.black54,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.shopping_cart_outlined,
                            size: 30,
                            color: Colors.black54,
                          ), onPressed: () {
                          navigateTo(context, CartsScreen());
                        },
                        ),
                        if (HomeCubit.get(context).inCartsModel?.data?.cartItems != null) Padding(
                          padding: const EdgeInsetsDirectional.only(bottom:6.5,end: 6.5),
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 7,
                            child: Text('${HomeCubit.get(context).inCartsModel?.data?.cartItems!.length}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.white
                              ),),
                          ),
                        ),

                      ],
                    ),
                  ),
                )
              ],
            ),
            floatingActionButton:
            BuildCondition(
              condition: state is !LoadingProductDataState && state is !ErrorProductDataState,
              builder: (context) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0,vertical: 6.0),
                child:
                HomeCubit.get(context).inCartsRealTime[productId] != true ?
                defaultButton(function: () {
                  HomeCubit.get(context).changeCarts(productId);
                },
                  text: 'Add To Carts',icon: Icons.add_shopping_cart,
                  radius: 20,
                )
                    :
                defaultButton(function: () {
                  navigateTo(context, CartsScreen());
                },
                    text: 'Checkout In Carts',
                  icon: Icons.shopping_cart,
                  background: Colors.red,
                  radius: 20,
                )
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
            body: BuildCondition(
              condition: HomeCubit.get(context).productDetails?.data != null && state is !LoadingProductDataState ,
              builder: (context) => BuildCondition(
                condition: state is !ErrorProductDataState,
                  builder: (context) => buildProduct(context,HomeCubit.get(context).productDetails!.data),
              fallback: (context) => Center(child: Text('Please check your internet and try again',style: TextStyle(color: Colors.grey,fontSize: 17),)),
              ),
              fallback: (context) => Center(
            child: RefreshProgressIndicator(),
          ),
            ),
          );
        }
    );
  }
  Widget buildProduct(context,ProductDetailsData? model) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8.0),
                child: Text('${model!.name}',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                  ),),
              ),
 Padding(
   padding: const EdgeInsets.symmetric(vertical: 8.0),
   child: Material(
     elevation: 0.7,
     color: Colors.white,
     borderRadius: BorderRadius.circular(35),
     child: Padding(
       padding: const EdgeInsets.all(12.0),
       child: Column(
         children: [
           Padding(
             padding: const EdgeInsets.symmetric(vertical: 8.0),
             child: Container(
               height: 200,
                 child:  PageView.builder(
                     physics: BouncingScrollPhysics(),
                     controller: productImages,
                     scrollDirection: Axis.horizontal,
                     itemBuilder: (context,index) => Image(
                       image: NetworkImage('${model.images![index]}',),
                     ) ,
                     itemCount: model.images!.length),
             ),
           ),
           Padding(
             padding: const EdgeInsets.all(12.0),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 SmoothPageIndicator(
                   controller: productImages,
                   count: model.images!.length,
                   effect: ExpandingDotsEffect(
                     activeDotColor: defaultColor,  //HexColor('2BD596'),
                     dotWidth: 12,
                     dotHeight: 12,
                   ),
                 ),
               ],
             ),
           ),
         ],
       ),

     ),
   ),
 ),


            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 5,),
                      Text('${model.price} EGP',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 25,
                      ),),
                      SizedBox(width: 5,),
                      if (model.discount!.round()!=0)
                        Text(
                        '${model.oldPrice!.round()}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.redAccent,
                          fontSize: 20,
                        ),
                      ),
                      Spacer(),
                      // IconButton(
                      //   icon: Icon(Icons.add_shopping_cart_outlined,
                      //       size: 27,
                      //     color: HexColor('1A925D')), onPressed: () {  },
                      // ),
                      IconButton(onPressed: () {
                        HomeCubit.get(context).changeFavorites(model.id);
                      },
                        highlightColor: Colors.transparent,
                        icon: HomeCubit.get(context).favoritesReailTime[productId] == true ?
                        Icon(Icons.favorite,
                          size: 30,color: HexColor('4C4E4D'),)
                            :
                        Icon(Icons.favorite_border_outlined,
                          size: 30,color: HexColor('4C4E4D'),),
                      ),
                    ],
                  ),

                  if (model.discount!.round()!=0)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 5,),
                        Text(
                          '${model.discount!.round()}% OFF',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w100
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: myDivider(2),
            ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800),),
                  Text('${model.description}'),
                ],
              ),
            )
        ]),
      ),
    );
  }
}
