import 'package:car_app/core/utils/app_text.dart';
import 'package:flutter/material.dart';

class CustomTitleAuthSection extends StatelessWidget {
  const CustomTitleAuthSection({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppTextStyles.h6());
  }
}
