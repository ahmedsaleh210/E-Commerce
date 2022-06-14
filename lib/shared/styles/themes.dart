import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

ThemeData lightmode = ThemeData(
primarySwatch: customColor, // تغيير لون الزراير في الابلكيشن
fontFamily: 'Jannah',
floatingActionButtonTheme: FloatingActionButtonThemeData(

backgroundColor: defaultColor,
foregroundColor: Colors.white,
),

scaffoldBackgroundColor: Colors.white,

appBarTheme: AppBarTheme(
titleSpacing: 20.0,
backwardsCompatibility: false, // للتحكم فال status bar

systemOverlayStyle: SystemUiOverlayStyle(

statusBarColor: Colors.white,

statusBarIconBrightness : Brightness.dark

),

backgroundColor: Colors.white,

elevation: 0.0,

iconTheme: IconThemeData(

color: Colors.black,

),

titleTextStyle: TextStyle(

color: Colors.black,

fontWeight: FontWeight.bold,

fontSize: 30.0,



)

),

bottomNavigationBarTheme: BottomNavigationBarThemeData(

type: BottomNavigationBarType.fixed,

selectedItemColor: defaultColor,

elevation: 30.0,

),

textTheme: TextTheme(

bodyText1: TextStyle(

color: Colors.black,

fontWeight: FontWeight.w600,

fontSize: 18.0,

),



) ,

);

ThemeData darkmode = ThemeData(

  fontFamily: 'Jannah',
  primarySwatch: customColor,
  scaffoldBackgroundColor: Colors.black26,

  appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      backwardsCompatibility: false, // للتحكم فال status bar

      systemOverlayStyle: SystemUiOverlayStyle(

          statusBarColor: Colors.black,

          statusBarIconBrightness : Brightness.light

      ),

      backgroundColor: Colors.black,

      elevation: 0.0,

      iconTheme: IconThemeData(

        color: Colors.white,

      ),

      titleTextStyle: TextStyle(

        color: Colors.white,

        fontWeight: FontWeight.bold,

        fontSize: 30.0,



      )

  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(

    type: BottomNavigationBarType.fixed,

    backgroundColor: Colors.black26,

    unselectedItemColor: Colors.grey,

    selectedItemColor: defaultColor,

    elevation: 30.0,

  ),

  textTheme: TextTheme(


    bodyText1: TextStyle(

      color: Colors.white,

      fontWeight: FontWeight.w600,

      fontSize: 18.0,

    ),



  ) ,


);