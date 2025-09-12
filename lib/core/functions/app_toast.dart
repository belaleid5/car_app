import 'package:car_app/core/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppToast {
  static show({
    required String message,
    Color color1 = AppColors.neutral900,
    Color color2 = AppColors.neutral100,
    ToastGravity gravity = ToastGravity.TOP,
    int timeInSecForIosWeb = 3,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: Colors.transparent, 
      textColor: Colors.white,
      fontSize: 16.0,
      webBgColor: "linear-gradient(to right, #000000, #434343)",
    );

  }
}


