import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/styles/colors.dart';


Widget defaultButton(
    {
      double? height,
      IconData? icon,
      double width = double.infinity,
      double radius = 30.0,
      Color background = customColor,
      required Function function,
      required String text,
    }) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
        boxShadow: [BoxShadow(
          color: Colors.grey.withOpacity(0.5),spreadRadius: 1,
          blurRadius: 4,
          offset: Offset(0, 2),

        ),]
      ),
      child: MaterialButton(onPressed: () {
        function();
      },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(icon,color: Colors.white,),
              ),
              Text(
               text,
                style: TextStyle(
                  fontSize: 20,
                    color: Colors.white
                ),
              ),
            ],
          ),
      ),
    );

void navigateTo(context,widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateAndFinish(context,widget) {
  Navigator.pushAndRemoveUntil(context, 
  MaterialPageRoute(builder: (context) => widget,),
  (route) => false
  
  );
}

Widget defaultformfield ({
  required TextEditingController controller,
  required TextInputType type,
  Function(String val)? onChanged,
  Function? onSuffixPress,
  String? Function(String? val)? onSupmited,

  String? Function(String? val)? validator,
  required String label,
  IconData? prefix,
  IconData? suffix,
  String? initialValue,
  bool isClickable=false,
  bool secure = false,
}

    ) =>
    TextFormField(
      controller: controller,
      initialValue: initialValue,
      obscureText: secure,
      keyboardType: type,
      style: TextStyle(
          fontWeight: FontWeight.bold,
      ),

      decoration: InputDecoration(
        labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
        ),

        labelText: label,
        prefixIcon: Icon(prefix,),
        suffixIcon: suffix!=null?IconButton(onPressed: () {onSuffixPress!();},
        icon: Icon(suffix,
        color: Colors.grey[600],),):null,
      ),
      onChanged: onChanged,
      readOnly: isClickable,
      validator: validator,
      onFieldSubmitted: onSupmited,

    );

Widget myDivider(double height,{
  Color? color = Colors.grey,
}) =>  Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20.0),
  child: Container(
    height: height,
    color: color,
    width: double.infinity,
  ),
);

void showToastMessage(String msg)
{
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 19.0
  );


}
