import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:flutter/material.dart';

class CustomTitleSplashScreen extends StatelessWidget {
  const CustomTitleSplashScreen({
    super.key,
    required this.res, required this.title,
  });

  final ResponsiveHelper res;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: res.sp(50),
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    );
  }
}