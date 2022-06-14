import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/cubit/cubit.dart';
import 'package:shop_app/layouts/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/modules/categoryproducts_screen/categoryproducts_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeLayoutStates>(
        listener: (context,state) {
        },
        builder: (context,state) {
          return Container(
            child: BuildCondition(
              condition: HomeCubit.get(context).categoriesModel != null,
              builder: (context) => categoriesList(HomeCubit.get(context).categoriesModel),
              fallback: (context) {
                return Center(
                  child: CircularProgressIndicator(),
                );} ,
            ),
          );
        }
    );
  }

  Widget categoriesList(CategoriesModel? model)
  {
    return ListView.separated(
        itemBuilder: (context,index) => categoriesBuilder(model!.data!.data![index],context),
        separatorBuilder:(context,index) => SizedBox(height: 0.1,),
        itemCount: model!.data!.data!.length);
  }

  Widget categoriesBuilder(DataModel? model,context)
  {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(30),
        elevation: 2.0,
        color: Colors.white,
        shadowColor: Colors.grey[50],
        child: InkWell(
          borderRadius: BorderRadius.circular(30),

          onTap: () {
            HomeCubit.get(context).getCatgoryProducts(model!.id);
            navigateTo(context, CategoryProductsScreen(model.name));
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                    image: NetworkImage('${model!.image}'),
                  ),
                ),
                SizedBox(width: 15,),
                Text('${model.name}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),),
                Spacer(),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.black54,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
