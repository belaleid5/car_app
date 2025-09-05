import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.res,
    this.onPressed,
    required this.titleColor,
    required this.buttonColor,
    required this.title,
    this.borderColor, // Add borderColor parameter
  });

  final ResponsiveHelper res;
  final void Function()? onPressed;
  final Color? titleColor;
  final Color? buttonColor;
  final String title;
  final Color? borderColor; // Add borderColor field

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(
          Size(res.availableWidth, res.rh(65)),
        ),
        backgroundColor: WidgetStateProperty.all(
          buttonColor ?? AppColors.neutral900,
        ),
        foregroundColor: WidgetStateProperty.all(titleColor ?? Colors.white),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(
              color: AppColors.neutral900, // Set border color
              width: 0.2, // You can adjust the width as needed
            ),
          ),
        ),
      ),
      child: Text(
        title,
        style: AppTextStyles.bodyLarge().copyWith(
          color: titleColor ?? Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
