import 'package:car_app/core/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomCircleImage extends StatelessWidget {
  const CustomCircleImage({
    super.key,
    required this.imagePath,
    this.radius = 25,
    this.borderColor = const Color.fromRGBO(163, 163, 163, 1),
    this.borderWidth = 0.4,
    this.radiusImage,
    this.height,
  });

  final String imagePath;
  final double radius;
  final Color borderColor;
  final double borderWidth;
  final double? radiusImage;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: CircleAvatar(
        radius: radiusImage ?? radius,
        backgroundColor: AppColors.white,
        child: SvgPicture.asset(
          color: AppColors.neutral600,
          imagePath,
          height: height ?? radius,
        ),
      ),
    );
  }
}
