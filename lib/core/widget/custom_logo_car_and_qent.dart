import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_images.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/core/widget/custom_icon_car.dart';
import 'package:flutter/material.dart';

class CustomLogoCarAndQent extends StatelessWidget {
  const CustomLogoCarAndQent({super.key, required this.res});

  final ResponsiveHelper res;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 10,
      children: [
        CustomIconCar(res: res, image: AppImages.assetsIconsCarIconBlack),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text('Qent', style: AppTextStyles.h5()),
        ),
      ],
    );
  }
}
