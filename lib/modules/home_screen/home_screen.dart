import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layouts/cubit/cubit.dart';
import 'package:shop_app/layouts/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/categoryproducts_screen/categoryproducts_screen.dart';
import 'package:shop_app/modules/product_screen/products_details.dart';
import 'package:shop_app/shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return BlocConsumer<HomeCubit,HomeLayoutStates>(
      listener: (context,state) {
        if (state is SucessFavoritesDataState)
        {
          if (state.model!.status==false)
            showToastMessage('${state.model!.message}');
        }
      },
      builder: (context,state) {
        return BuildCondition(
        condition: HomeCubit.get(context).homeModel != null && HomeCubit.get(context).categoriesModel != null,
        builder: (context) => homeBuilder (HomeCubit.get(context).homeModel,HomeCubit.get(context).categoriesModel,context),
        fallback: (context) {
          return Center(
            child: RefreshProgressIndicator(),
          );} ,
          );
      }
    );
  }
  Widget homeBuilder(HomeModel? model, CategoriesModel? categoriesModel,context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          CarouselSlider(
              items: model?.data.banners.map((e) =>
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                      ),
                  ), ).toList(),
              options: CarouselOptions(
                height: 270,
                initialPage: 0,
                enableInfiniteScroll: true,
                viewportFraction: 1.0,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Categories',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800
                ),),
                Container(
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index) => categoriesBuilder(categoriesModel!.data!.data![index],context) ,
                      separatorBuilder: (context,index) => SizedBox(width: 15,),
                      itemCount: categoriesModel!.data!.data!.length),
                ),
                SizedBox(height: 15,),
                Text('Hot Deals',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800
                  ),),
              ],
            ),
          ),
          SizedBox(height: 5,),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 15.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1/1.4,

            children: List.generate(model!.data.products.length, (index) => buildProductView(model.data.products[index],context,index)
            ),

          )
        ],
      ),
    ),
  );
Widget buildProductView(ProductModel model,context,index) => Material(
  elevation: 1.2,

  color: Colors.white,
  borderRadius: BorderRadius.circular(25),
  child: InkWell(
    borderRadius: BorderRadius.circular(25),
    onTap: () {
      HomeCubit.get(context).getProductData(model.id);
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
                      image: NetworkImage('${model.image}'),

                    ),
                  ),
                  if (model.discount.round()!=0)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0,),
                      child: Text('Discount ${model.discount.round()}%',
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
                  '${model.price.round()} EGP',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: HexColor('10BD70'),
                  ),
                ),
                SizedBox(width: 5,),
                if (model.discount.round()!=0)
                Text(
                  '${model.oldPrice.round()}',
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
);

Widget categoriesBuilder(DataModel? model,context) => InkWell(
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  onTap: () {
    HomeCubit.get(context).getCatgoryProducts(model!.id);
    navigateTo(context, CategoryProductsScreen(model.name));
  },
  child:   ClipRRect(

    borderRadius: BorderRadius.circular(15.0),

    child: Stack(

    alignment: AlignmentDirectional.bottomEnd,

    children: [

    Image(

    image: NetworkImage('${model!.image}'),

    height: 100,

    width: 100,

    fit: BoxFit.cover,

    ),

    Container(

    color: Colors.black.withOpacity(0.9),

    width:100,

    child: Text(

    '${model.name}',

    textAlign: TextAlign.center,

    overflow: TextOverflow.ellipsis,

    maxLines: 1,

    style: TextStyle(

    color: Colors.white,

    ),

    ),

    )

    ],

    ),

    ),
);
}