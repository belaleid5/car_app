import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomButtonSocial extends StatelessWidget {
  const CustomButtonSocial({
    super.key,
    required this.res,
    required this.title,
    required this.imagePath,
    this.onPressed,
  });

  final ResponsiveHelper res;
  final String title;
  final String imagePath;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(res.availableWidth, res.rh(65)),
        backgroundColor: AppColors.neutral100,
        foregroundColor: AppColors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(
            color: AppColors.neutral900, // Set border color
            width: 0.2, // You can adjust the width as needed
          ),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(imagePath, width: res.rh(24), height: res.rh(24)),
          Text(
            title,
            style: AppTextStyles.bodyLarge().copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
