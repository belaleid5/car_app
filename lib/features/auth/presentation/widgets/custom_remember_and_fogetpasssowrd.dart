import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/features/auth/presentation/widgets/custom_checkbox.dart';
import 'package:flutter/material.dart';

class CustomRememberAndForgetPassword extends StatelessWidget {
  const CustomRememberAndForgetPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomCheckbox(),
        Text(
          'Remember Me',
          style: AppTextStyles.bodySmall(
            
          ).copyWith(color: AppColors.black),
        ),
        Spacer(),
        TextButton(
          onPressed: () {},
          child: Text(
            'Forgot Password?',
            style: AppTextStyles.bodySmall(
            ).copyWith(color: AppColors.black),
          ),
        ),
      ],
    );
  }
}