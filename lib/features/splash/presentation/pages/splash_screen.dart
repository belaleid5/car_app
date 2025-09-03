import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_images.dart';
import 'package:car_app/core/widget/custom_icon_car.dart';
import 'package:car_app/core/widget/cutsom_eleveted_button.dart';
import 'package:car_app/features/splash/presentation/widgets/custom_title_splash_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.assetsBaground_car),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: res.rw(24),
            vertical: res.rh(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: res.rh(60)),
              CustomIconCar(res: res),
              SizedBox(height: res.rh(20)),
              CustomTitleSplashScreen(res: res, title: 'Welcome to\nQent'),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}










