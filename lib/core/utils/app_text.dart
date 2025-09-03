import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static TextStyle inter33(BuildContext context) {
    final res = ResponsiveHelper(context);
    return TextStyle(
      fontSize: res.sp(33),
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle poppins58(BuildContext context) {
    final res = ResponsiveHelper(context);
    return TextStyle(
      fontSize: res.sp(58),
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle inter20(BuildContext context) {
    final res = ResponsiveHelper(context);
    return TextStyle(
      fontSize: res.sp(20),
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle poppins14(BuildContext context) {
    final res = ResponsiveHelper(context);
    return TextStyle(fontSize: res.sp(14));
  }

  static TextStyle poppins15(BuildContext context) {
    final res = ResponsiveHelper(context);
    return TextStyle(
      fontSize: res.sp(15),
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle poppins18(BuildContext context) {
    final res = ResponsiveHelper(context);
    return TextStyle(
      fontSize: res.sp(18),
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle semiBold16(BuildContext context) {
    final res = ResponsiveHelper(context);
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: res.sp(16),
    );
  }

  static TextStyle bold28(BuildContext context) {
    final res = ResponsiveHelper(context);
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: res.sp(28),
    );
  }

  static TextStyle regular22(BuildContext context) {
    final res = ResponsiveHelper(context);
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: res.sp(22),
    );
  }

  static TextStyle semiBold11(BuildContext context) {
    final res = ResponsiveHelper(context);
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: res.sp(11),
    );
  }

  static TextStyle medium15(BuildContext context) {
    final res = ResponsiveHelper(context);
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: res.sp(15),
    );
  }

  static TextStyle regular26(BuildContext context) {
    final res = ResponsiveHelper(context);
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: res.sp(26),
    );
  }

  static TextStyle regular16(BuildContext context) {
    final res = ResponsiveHelper(context);
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: res.sp(16),
    );
  }

  static TextStyle regular11(BuildContext context) {
    final res = ResponsiveHelper(context);
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: res.sp(11),
    );
  }
}
