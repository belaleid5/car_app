import 'package:car_app/core/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomShimmerWidget extends StatelessWidget {
  const CustomShimmerWidget({
    super.key,
    required this.shimmerWidget, 
  });

  final Widget shimmerWidget;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      enableSwitchAnimation: true,
      effect: const ShimmerEffect(
        baseColor: AppColors.neutral800,
    
        duration: Duration(milliseconds: 1500),
      ),
      child: shimmerWidget,
    );
  }
}