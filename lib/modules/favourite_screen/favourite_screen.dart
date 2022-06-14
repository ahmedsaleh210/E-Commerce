import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layouts/cubit/cubit.dart';
import 'package:shop_app/layouts/cubit/states.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/modules/product_screen/products_details.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class FavouritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeLayoutStates>(
        listener: (context,state) {
          if (state is SucessCartsDataState)
            showToastMessage('${state.inCartsModel!.message}');

        },
        builder: (context,state) {
          return Container(
            height: double.infinity,
          child: BuildCondition(
          condition: HomeCubit.get(context).favoritesModel?.data?.data != null,
          builder: (context) =>
              BuildCondition(
                condition: HomeCubit.get(context).favoritesModel!.data!.total != 0,
                  builder: (context) => favoritesList(HomeCubit.get(context).favoritesModel),
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
                      Text('Your Favorites is empty',style: TextStyle(fontSize: 25),),
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
          );
        }
    );
  }

  Widget favoritesList(FavoritesModel? favoritesModel)
  {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index) => favoritesBuilder(HomeCubit.get(context).favoritesModel!.data!.data![index],context,index),
                separatorBuilder:(context,index) => SizedBox(height: 2,),
                itemCount: favoritesModel!.data!.data!.length),
          ),
          SizedBox(height: 5,),
          Text('You Have ${favoritesModel.data!.total} ${favoritesModel.data!.total==1?'item':'items'}'),
        ],
      ),
    );
  }

  Widget favoritesBuilder(FavoritesData? model,context,index) => Padding(
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
                      child: Text('Discount ${model.product!.discount.round()}%',
                        style: TextStyle(
                          color: Colors.white,
                        ),),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 20,),
              Expanded(
                child: Container(
                  height: 120.0,
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
                          Text('${model.product!.price} EGP',

                            maxLines:2 ,
                            overflow: TextOverflow.ellipsis ,
                            style: TextStyle(
                              color: defaultColor,
                              fontSize: 15
                            ),
                          ),
                          SizedBox(width: 5,),
                          if (model.product!.discount!.round()!=0)
                          Text('${model.product!.oldPrice}',
                            maxLines:2 ,
                            overflow: TextOverflow.ellipsis ,
                            style: TextStyle(
                              fontSize: 15,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.redAccent,
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: HomeCubit.get(context).inCartsRealTime[model.product!.id] != true ? Icon(
                                    Icons.add_shopping_cart, //Icons.remove_shopping_cart,
                                    color: HexColor('1A925D') ,

                                  ) : Icon(
                                    Icons.remove_shopping_cart, //Icons.remove_shopping_cart,
                                    color: HexColor('1A925D') ,

                                  ),

                                  onPressed: () {
                                    HomeCubit.get(context).changeCarts(model.product!.id);
                                },
                                ),
                                SizedBox(width: 10,),
                                InkWell(
                                  onTap: () {
                                    if (HomeCubit.get(context).favoritesReailTime[model.product!.id] == true)
                                    HomeCubit.get(context).changeFavorites(model.product!.id);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete_outline_outlined,color:Colors.black54,),
                                      Text('Remove',style: TextStyle(color: Colors.black54),)
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
