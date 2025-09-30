import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomCardBestCars extends StatelessWidget {
  final String carImage;
  final String carName;
  final double rating;
  final String location;

  final String seats;
  final String dollarIconPath;

  final String pricePerDay;
  final String heartIconPath;
  final String locationIconPath;
  final String seatIconPath;
  final VoidCallback? onTap;
  final VoidCallback? onHeartTap;

  const CustomCardBestCars({
    super.key,
    required this.carImage,
    required this.carName,
    required this.rating,
    required this.location,
    required this.seats,
    required this.pricePerDay,
    required this.heartIconPath,
    required this.locationIconPath,
    required this.seatIconPath,
    this.onTap,
    this.onHeartTap,
    required this.dollarIconPath,
  });

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          width: res.wp(200),
          decoration: BoxDecoration(
            color: AppColors.neutral50,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: AppColors.neutral400.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: res.screenHeight * 0.1700,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.neutral300,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.asset(
                        carImage,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.neutral400,
                            child: const Center(
                              child: Icon(
                                Icons.car_rental,
                                size: 40,
                                color: AppColors.neutral400,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: GestureDetector(
                        onTap: onHeartTap,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            heartIconPath,
                            width: 16,
                            height: 16,
                            colorFilter: const ColorFilter.mode(
                              AppColors.neutral400,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.neutral50,
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          carName,
                          style: AppTextStyles.bodySmall(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              rating.toString(),
                              style: AppTextStyles.bodySmall(),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            SvgPicture.asset(
                              locationIconPath,
                              width: 14,
                              height: 14,
                              colorFilter: const ColorFilter.mode(
                                AppColors.neutral400,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                location,
                                style: AppTextStyles.bodySmall(color: AppColors.neutral300),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  seatIconPath,
                                  width: 14,
                                  height: 14,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.neutral400,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  seats,
                                  style: AppTextStyles.labelSmall(color: AppColors.neutral400)
                                ),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  dollarIconPath,
                                  width: 14,
                                  height: 14,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.neutral400,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  pricePerDay,
                                  style: AppTextStyles.bodySmall()
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
