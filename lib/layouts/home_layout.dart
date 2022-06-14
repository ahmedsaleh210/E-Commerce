import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/cubit/cubit.dart';
import 'package:shop_app/modules/cart_screen/cart_screen.dart';
import 'package:shop_app/modules/search_screen/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';
//import 'package:shop_app/shared/components/components.dart';
import 'cubit/states.dart';
// import 'package:shop_app/modules/Loginscreen/login_screen.dart';
// import 'package:shop_app/shared/components/components.dart';
// import 'package:shop_app/shared/network/local/shared_preferences.dart';

class HomeLayout extends StatelessWidget {
final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeLayoutStates>(
      listener: (context,state) {} ,
      builder: (context,state)
      {

        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Shop App'),
            actions: [
              // TextFormField(
              //   controller: searchController,
              //   keyboardType: TextInputType.text,
              //   decoration: InputDecoration(
              //     filled: true,
              //     fillColor: Colors.grey.withOpacity(0.1),
              //     contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              //     labelStyle: TextStyle(
              //         fontWeight: FontWeight.w800,
              //         color: Colors.black54
              //     ),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //       borderSide: BorderSide(
              //         color: Colors.black26,
              //       ),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //       borderSide: BorderSide(
              //         color: Colors.black26,
              //       ),
              //     ),
              //     labelText: 'Search',
              //     prefixIcon: Icon(Icons.search,
              //       // color: AppCubit.get(context).isDark == true ? Colors.grey : Colors.black,),
              //     ),
              //
              //
              //   ),
              // ),

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
          body: cubit.shopScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeScreen(index);
            },
            currentIndex: cubit.currentIndex,
            iconSize: 25,

            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: 'Home',),
              BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories',),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Whishlist',),
              BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: 'Account',),
            ],
          ),
        );
      },
    );
  }
}

// TextButton(
//         onPressed: () {
//           navigateAndFinish(context, LoginScreen())
//           CacheHelper.removeToken(key: 'token');
//         },
//         child: Text('signout'),
//       ),
