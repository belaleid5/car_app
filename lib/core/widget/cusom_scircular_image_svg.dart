import 'package:car_app/core/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomCircleImage extends StatelessWidget {
  const CustomCircleImage({super.key, required this.imagePath, t});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: AppColors.white,
      child: SvgPicture.asset(imagePath),
    );
  }
}