import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key, required this.res, this.onPressed});

  final ResponsiveHelper res;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(res.rw(343), res.rh(56)),
        backgroundColor: AppColor.colorButton,
      ),
      onPressed: onPressed,
      child: Text(
        'Get Started',
        style: AppTextStyles.poppins18(
          context,
        ).copyWith(color: AppColor.whiteColor),
      ),
    );
  }
}
