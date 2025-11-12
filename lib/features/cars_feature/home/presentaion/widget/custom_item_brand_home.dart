import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/features/cars_feature/home/domain/entity/brands_entity.dart';
import 'package:flutter/material.dart';

class CustomItemBrandHome extends StatelessWidget {
  const CustomItemBrandHome({
    super.key,
    required this.brand,
  });

  final BrandEntity brand;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to brand details
      },
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.white.withOpacity(0.8),
              radius: 35,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: brand.image,
                  fit: BoxFit.cover,
                  width: 50,
                  height: 80,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              brand.name,
              style: AppTextStyles.labelSmall(),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}