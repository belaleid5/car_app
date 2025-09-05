import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:flutter/material.dart';

class CustomTitleSectionVerifyPhone extends StatelessWidget {
  const CustomTitleSectionVerifyPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Text(
          'Verify your phone number',
          style: AppTextStyles.h5().copyWith(color: AppColors.black),
        ),

        Text(
          'We have sent you an SMS with a code to number',
          style: AppTextStyles.bodySmall().copyWith(
            color: AppColors.neutral500,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
