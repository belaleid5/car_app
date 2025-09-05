import 'package:car_app/core/extention/text_span_services.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:flutter/material.dart';

class DontHaveAccount extends StatelessWidget {
  const DontHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextSpanServices.richTextFromSpans(
        textSpans: [
          TextSpanServices.createTextSpan(
            text: "Don't have an account? ",
            style: AppTextStyles.bodySmall().copyWith(
              color: AppColors.neutral500,
            ),
          ),
          TextSpanServices.createClickableTextSpan(
            text: "Sign Up",
            style: AppTextStyles.bodySmall().copyWith(color: AppColors.black),
            onTap: () {
              Navigator.pushNamed(context, '/signup');
            },
          ),
        ],
        textAlign: TextAlign.center,
      ),
    );
  }
}
