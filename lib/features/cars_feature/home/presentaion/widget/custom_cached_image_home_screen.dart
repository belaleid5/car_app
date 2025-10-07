import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/widget/custom_shimmer_card.dart';
import 'package:flutter/material.dart';

class CachedImageCarsHomeScreen extends StatelessWidget {
  const CachedImageCarsHomeScreen({
    super.key,
    required this.carImage,
    required this.res,
  });

  final String carImage;
  final ResponsiveHelper res;

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: const BoxDecoration(
      color: AppColors.neutral300,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
        child: CachedNetworkImage(
          imageUrl: carImage,
          height: res.screenHeight * 0.18,
          fit: BoxFit.fill,
          placeholder: (context, url) => Container(
            color: AppColors.neutral300,
            child: CustomShimmerCard(res: res,),
          ),
          errorWidget: (context, url, error) {
            debugPrint('Image error: $error');
            return Container(
              color: AppColors.neutral300,
              child: const Icon(Icons.directions_car, size: 50),
            );
          },
        ),
      ),
    );
  }
}
