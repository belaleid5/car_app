import 'package:car_app/core/extention/text_span_services.dart';
import 'package:car_app/core/routing/app_router.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:flutter/material.dart';

class DontHaveOrHaveAccount extends StatelessWidget {
  const DontHaveOrHaveAccount({super.key,  this.title,  this.titleButton, this.onTap});

  final String ? title;
  final String ? titleButton;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextSpanServices.richTextFromSpans(
        textSpans: [
          TextSpanServices.createTextSpan(
            text:  title ?? "Don't have an account? ",
            style: AppTextStyles.bodySmall().copyWith(
              color: AppColors.neutral500,
            ),
          ),
          TextSpanServices.createClickableTextSpan(
            text: titleButton ?? "Sign Up",
            style: AppTextStyles.bodySmall().copyWith(color: AppColors.black),
            onTap: onTap ?? () {
              Navigator.pushNamed(context, AppRouter.signUpRoute);
            },
          ),
        ],
        textAlign: TextAlign.center,
      ),
    );
  }
}
