import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_images.dart';
import 'package:car_app/core/widget/custom_logo_car_and_qent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return Scaffold(
      backgroundColor: AppColors.neutral100,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.only(top:28),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: AppColors.neutral100,
                elevation: 0.0,
                toolbarHeight: 70,
                leadingWidth: 200,
                leading: CustomLogoCarAndQent(res: res),
                actions: [
                  CustomCircleImage(imagePath: AppImages.assetsIconsNotificationIcon,),
                  CustomCircleImage(imagePath: AppImages.persion_image,)] 
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCircleImage extends StatelessWidget {
  const CustomCircleImage({super.key, required this.imagePath});
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
