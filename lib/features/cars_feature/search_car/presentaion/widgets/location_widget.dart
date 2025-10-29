import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_images.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LocationWidget extends StatelessWidget {
  final String location;

  const LocationWidget({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 8),
      child: Row(
        children: [
          SvgPicture.asset(
            AppImages.assetsIconsMapIcon,
            width: 14,
            height: 14,
            color: AppColors.neutral500,
          ),
          const SizedBox(width: 6),
          Text(
            location,
            style: AppTextStyles.labelSmall(
              color: AppColors.neutral500,
            ),
          ),
        ],
      ),
    );
  }
}