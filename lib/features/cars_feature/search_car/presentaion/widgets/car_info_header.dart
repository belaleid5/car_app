import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:flutter/material.dart';

class CarInfoHeader extends StatelessWidget {
  final String carName;

  const CarInfoHeader({
    super.key,
    required this.carName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        top: 8,
      ),
      child: Text(
        carName,
        style: AppTextStyles.labelMedium(
          color: AppColors.neutral900,
        ),
      ),
    );
  }
}