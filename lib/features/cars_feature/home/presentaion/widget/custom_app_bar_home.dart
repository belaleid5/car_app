import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_images.dart';
import 'package:car_app/core/widget/cusom_scircular_image_svg.dart';
import 'package:car_app/core/widget/custom_logo_car_and_qent.dart';
import 'package:flutter/material.dart';

class CustomAppBarHome extends StatelessWidget {
  const CustomAppBarHome({
    super.key,
    required this.res,
  });

  final ResponsiveHelper res;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        backgroundColor: AppColors.neutral100,
        elevation: 0.0,
        toolbarHeight: 70,
        leadingWidth: 200,
        leading: CustomLogoCarAndQent(res: res),
        actions: [
          CustomCircleImage(
            imagePath: AppImages.assetsIconsNotificationIcon,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: AppColors.white,
              child: Image.asset(AppImages.persion_image),
            ),
          ),
        ]);
  }
}
