import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/cubit/cubit.dart';
import 'package:shop_app/models/product_search.dart';
import 'package:shop_app/modules/product_screen/products_details.dart';
import 'package:shop_app/modules/search_screen/search_cubit.dart';
import 'package:shop_app/modules/search_screen/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
 final searchController = TextEditingController();
 final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return SearchCubit();
      },
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state) {},
        builder: (context,state)
        {
        return  Scaffold(
                  appBar: AppBar(
                    title: Text('Search'),
                  ),
                  body: Container(
                    color:Colors.grey.withOpacity(0.05),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: formkey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all (8.0),
                              child: Container(
                                height: 60,
                                child: TextFormField(
                                  autofocus: true,
                                  controller: searchController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    labelText: 'Search',
                                    prefixIcon: Icon(
                                      Icons.search,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty)
                                      {
                                        return 'Enter text to search';
                                      }
                                    return null;
                                  },
                                  onFieldSubmitted: (value)
                                  {
                                    SearchCubit.get(context).search(value);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            if (state is LoadingState)
                            LinearProgressIndicator(
                              backgroundColor: Colors.grey.withOpacity(0.6),
                              color: defaultColor.withOpacity(0.3),
                            ),
                            SizedBox(height: 15,),
                            if (state is SucessState)
                              BuildCondition(
                                condition: SearchCubit.get(context).searchModel!.data!.data!.length!=0,
                                builder: (context) => Expanded(
                                child: ListView.separated(
                                    itemBuilder: (context,index) => searchBuilder(SearchCubit.get(context).searchModel!.data!.data![index],context,index),
                                    separatorBuilder:(context,index) => SizedBox(height: 2,),
                                    itemCount: SearchCubit.get(context).searchModel!.data!.data!.length),
                            ),
                                fallback: (context) => Center(child: Text(
                                    'No items found',
                                  style: TextStyle(
                                    fontSize: 20.0
                                  ),
                                ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    )
                  ),
                );
        }
        ),
    );
  }
 Widget searchBuilder(ProductSearchDataData?model,context,index) => Padding(
   padding: const EdgeInsets.all(5.0),
   child: Material(
     color: Colors.white,
     borderRadius: BorderRadius.circular(10),
     elevation: 1,

     child: InkWell(
       onTap: (){
         HomeCubit.get(context).getProductData(model!.id);
         navigateTo(context, ProductDetailsScreen(model.id));
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
                       image: NetworkImage('${model!.image}'),
                     ),
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
                         '${model.name}',
                         maxLines:2 ,
                         overflow: TextOverflow.ellipsis ,
                         style: TextStyle(
                             fontSize: 15
                         ),
                       ),
                     ),
                     Row(
                       children: [
                         Text('${model.price} EGP',

                           maxLines:2 ,
                           overflow: TextOverflow.ellipsis ,
                           style: TextStyle(
                               color: defaultColor,
                               fontSize: 15
                           ),
                         ),
                         SizedBox(width: 5,),
                         Spacer(),
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
                           child: Row(
                             children: [
                               SizedBox(width: 10,),
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
