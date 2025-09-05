import 'package:car_app/core/utils/app_text.dart';
import 'package:flutter/material.dart';

class CustomTitleAuthSection extends StatelessWidget {
  const CustomTitleAuthSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Welcome Back\nReady to hit the road.',
      style: AppTextStyles.h6(),
    );
  }
}