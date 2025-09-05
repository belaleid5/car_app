import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_images.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/core/widget/custom_icon_car.dart';
import 'package:flutter/material.dart';

class SplashScreenTow extends StatelessWidget {
  const SplashScreenTow({super.key});

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.assetsBaground_car_tow),
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
              SizedBox(height: res.rh(30)),
              CustomIconCar(res: res),
              SizedBox(height: res.rh(20)),
              Text(
                'Lets Start\nA New Experience \nWith Car rental.',
                style: TextStyle(
                  fontSize: res.sp(35),
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: res.rh(80 * 3)),

              Text(
                "Discover your next adventure with Qent.we’re here to provide you with a seamless car rental experience.Let’s get started on your journey.",
                style: AppTextStyles.bodyMedium(

                ).copyWith(color: AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
