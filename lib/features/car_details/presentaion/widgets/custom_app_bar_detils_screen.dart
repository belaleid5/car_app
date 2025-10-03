import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_images.dart';
import 'package:car_app/core/widget/cusom_scircular_image_svg.dart';
import 'package:flutter/material.dart';

class CustomAppBarDetilsScreen extends StatelessWidget {
  const CustomAppBarDetilsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
          backgroundColor: AppColors.neutral100.withOpacity(  0.4),
      pinned: true,
      centerTitle: true,
      title: Text(
        "Car Details",
        style: TextStyle(
          color: AppColors.neutral900,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomCircleImage(imagePath: AppImages.iconBack),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomCircleImage(imagePath: AppImages.threeDotsIcon),
        ),
      ],
    );
  }
}