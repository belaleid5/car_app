import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:flutter/material.dart';

class CustomTitleSectionVerify extends StatelessWidget {
  const CustomTitleSectionVerify({super.key, required this.title, required this.subTitle});

final String title,subTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Text(
          title,
          style: AppTextStyles.h5().copyWith(color: AppColors.black),
        ),

        Text(
          subTitle,
          style: AppTextStyles.bodySmall().copyWith(
            color: AppColors.neutral500,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
