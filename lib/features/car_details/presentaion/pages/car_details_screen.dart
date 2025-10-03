import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/features/car_details/presentaion/widgets/custom_app_bar_detils_screen.dart';
import 'package:flutter/material.dart';

class CarDetailsScreen extends StatelessWidget {
  const CarDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral100.withOpacity(  0.4),
      body: CustomScrollView(
        slivers: [
          CustomAppBarDetilsScreen(),
        ],
      ),
    );
  }
}





