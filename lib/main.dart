import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/cubit/cubit.dart';
import 'package:shop_app/layouts/home_layout.dart';
import 'package:shop_app/modules/Loginscreen/login_screen.dart';
import 'package:shop_app/shared/BlocObserver.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';
import 'package:shop_app/shared/network/remote/diohelper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'layouts/cubit/states.dart';
import 'modules/on_boarding/onboarding.dart';

void main() async
{
    WidgetsFlutterBinding.ensureInitialized();
    Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  dynamic finishedOnBoarding = CacheHelper.getData(key: 'onBoardingScreen');
  token = CacheHelper.getData(key: 'token');
  accountName = CacheHelper.getData(key: 'name');
  imageId = CacheHelper.getData(key: 'imageId');
  print(finishedOnBoarding !=null ? finishedOnBoarding : false);
  final Widget startwidget;
  if (finishedOnBoarding != null)
    {
      if (token != null) startwidget = HomeLayout();
      else startwidget = LoginScreen();
    } else startwidget = OnBoardingScreen();
  runApp(MyApp(
      startwidget: startwidget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startwidget;
  // This widget is the root of your application.
  MyApp({
    required this.startwidget,
});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
      return HomeCubit()
          ..getHomeData()
          ..getUserData()
          ..getCatgories()
          ..getFavorites()
          ..getCarts()
          ..getFaqs()
          ..getAddress();
      },
      child: BlocConsumer<HomeCubit,HomeLayoutStates>(
        listener: (context,state) {},
        builder: (context,state) {
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,]);
        return MaterialApp(
            theme: lightmode,
            darkTheme: darkmode,
            debugShowCheckedModeBanner: false,
            home: startwidget,
          );
        },

      ),
    );
  }
}


