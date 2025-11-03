import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_images.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardOurPopularCars extends StatelessWidget {
  final String carName;
  final double rating;
  final String location;
  final int pricePerDay;
  final String imageUrl;

  const CardOurPopularCars({
    super.key,
    required this.carName,
    required this.rating,
    required this.location,
    required this.pricePerDay,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        width: res.widthPercent(65),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Car Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[200],
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Icon(
                            Icons.directions_car,
                            size: 40,
                            color: Colors.grey[600],
                          ),
                        )
                      : Icon(
                          Icons.directions_car,
                          size: 40,
                          color: Colors.grey[600],
                        ),
                ),
              ),
              const SizedBox(width: 12),

              // Car Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      carName,
                      style: AppTextStyles.labelMedium(
                        color: AppColors.neutral900,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppImages.starIcons,
                          width: 14,
                          height: 14,
                          color: AppColors.warning500,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          rating.toStringAsFixed(1),
                          style: AppTextStyles.labelSmall(
                            color: AppColors.neutral500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppImages.assetsIconsMapIcon,
                          width: 14,
                          height: 14,
                          color: AppColors.neutral500,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            location,
                            style: AppTextStyles.labelSmall(
                              color: AppColors.neutral500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$$pricePerDay/Day',
                      style: AppTextStyles.labelSmall(
                        color: AppColors.neutral800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
