import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_images.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RatingWidget extends StatelessWidget {
  final double rating;

  const RatingWidget({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 5),
      child: Row(
        children: [
          SvgPicture.asset(
            AppImages.starIcon,
            width: 14,
            height: 14,
            color: AppColors.warning500,
          ),
          const SizedBox(width: 4),
          Text(
            rating.toString(),
            style: AppTextStyles.labelSmall(
              color: AppColors.neutral500,
            ),
          ),
        ],
      ),
    );
  }
}