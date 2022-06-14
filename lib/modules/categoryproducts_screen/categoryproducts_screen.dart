import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layouts/cubit/cubit.dart';
import 'package:shop_app/layouts/cubit/states.dart';
import 'package:shop_app/models/cat_products_model.dart';
import 'package:shop_app/modules/cart_screen/cart_screen.dart';
import 'package:shop_app/modules/product_screen/products_details.dart';
import 'package:shop_app/modules/search_screen/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class CategoryProductsScreen extends StatelessWidget {

  final String? name;
  CategoryProductsScreen(this.name);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeLayoutStates>(
      listener: (context,state) {

      },
    builder: (context,state) {
      var cubit = HomeCubit.get(context);
     return Scaffold(
        appBar: AppBar(
          title: Text('$name'),
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
        body: BuildCondition(
          condition: cubit.categoryProdcuts != null && state is !LoadingCategoryProducts,
          builder: (context) =>
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 15.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 1 / 1.4,

                      children: List.generate(cubit.categoryProdcuts!.data!.data!.length, (index) =>
                          buildProductView(
                              cubit.categoryProdcuts?.data?.data?[index], context, index)
                      ),

                    ),
                  ],
                ),
              ),
          fallback: (context) => Center(child:CircularProgressIndicator()),
        ),
      );
    }
    );
  }
  Widget buildProductView(CategoryProductsDataData? model,context,index) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.0),
    child: Material(
      elevation: 1.2,

      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          HomeCubit.get(context).getProductData(model!.id);
          navigateTo(context, ProductDetailsScreen(model.id));
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child:   Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                          height: 210,
                          width: double.infinity,
                          image: NetworkImage('${model!.image}'),

                        ),
                      ),
                      if (model.discount!.round()!=0)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0,),
                            child: Text('Discount ${model.discount!.round()}%',
                              style: TextStyle(
                                color: Colors.white,
                              ),),
                          ),
                        )
                    ],
                  ),
                  SizedBox(height: 7,),
                  Center(
                    child: Text(model.name.toString(),
                      style: TextStyle(
                          height: 1.3
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,),
                  ),
                ],
              ),
              SizedBox(height: 8,),
              myDivider(0.7),
              Expanded(
                child: Row(
                  children: [
                    SizedBox(width: 5,),
                    Text(
                      '${model.price!.round()} EGP',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: HexColor('10BD70'),
                      ),
                    ),
                    SizedBox(width: 5,),
                    if (model.discount!.round()!=0)
                      Text(
                        '${model.oldPrice!.round()}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.redAccent,
                        ),
                      ),
                    Spacer(),
                    IconButton(onPressed: () {
                      HomeCubit.get(context).changeFavorites(model.id);
                    },
                      highlightColor: Colors.transparent,
                      icon: HomeCubit.get(context).favoritesReailTime[model.id] == true ?
                      Icon(Icons.favorite,
                        size: 25,color: HexColor('4C4E4D'),)
                          :
                      Icon(Icons.favorite_border_outlined,
                        size: 25,color: HexColor('4C4E4D'),),
                    ),


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
