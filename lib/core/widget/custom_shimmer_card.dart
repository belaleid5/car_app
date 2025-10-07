import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomShimmerCard extends StatelessWidget {
  const CustomShimmerCard({super.key, required this.res});

  final ResponsiveHelper res;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        width: res.screenWidth * 0.75, // حجم مناسب للعرض الأفقي
        margin: const EdgeInsets.only(right: 12), // مسافة بين الكروت
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الحل 1: استخدم Expanded بدلاً من height ثابت
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ShimmerTextLine(height: 14, width: 100),
                  const SizedBox(height: 6),
                  _ShimmerTextLine(height: 12, width: 80),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _ShimmerTextLine(height: 12, width: 60),
                      const Spacer(),
                      _ShimmerTextLine(height: 14, width: 40),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ShimmerTextLine({required double height, required double width}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}