import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomIconCar extends StatelessWidget {
  const CustomIconCar({
    super.key,
    required this.res,
    this.color,
    this.backgroundColor, this.image,
  });

  final ResponsiveHelper res;
  final Color? color;
  final Color? backgroundColor;
  final String ?image;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor ?? AppColors.white,
      radius: res.rw(35),
      child: SvgPicture.asset(
        color: color ?? color,
        image ?? AppImages.assetsIconsCarIcon,
        width: res.rw(74),
        height: res.rh(74),
      ),
    );
  }
}
