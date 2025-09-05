import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:flutter/material.dart';

class CustomTitleSectionScreen extends StatelessWidget {
  const CustomTitleSectionScreen({
    super.key,
    required this.res,
    required this.title, 
    this.color,
  });

  final ResponsiveHelper res;
  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: res.sp(50),
        
        fontWeight: FontWeight.w700,
        color: color ?? Colors.white,
      ),
    );
  }
}
