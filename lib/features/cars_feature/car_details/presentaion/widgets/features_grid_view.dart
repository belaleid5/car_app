import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_images.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/core/widget/cusom_scircular_image_svg.dart';
import 'package:flutter/material.dart';

class FeaturesGridView extends StatelessWidget {
  final ResponsiveHelper res;

  const FeaturesGridView({
    super.key,
    required this.res,
  });

  @override
  Widget build(BuildContext context) {
    final features = [
      {
        'icon': AppImages.assetsIconsSeatIcon,
        'text': '4 Seats',
        'label': 'Capacity'
      },
      {'icon': AppImages.assetsIconsAppleIcon, 'text': '2022', 'label': 'Year'},
      {
        'icon': AppImages.assetsIconsDollerIcon,
        'text': 'Electric',
        'label': 'Fuel Type'
      },
      {
        'icon': AppImages.assetsIconsCarIconBlack,
        'text': 'Automatic',
        'label': 'Transmission'
      },
      {
        'icon': AppImages.assetsIconsSeatIcon,
        'text': 'GPS',
        'label': 'Navigation'
      },
      {
        'icon': AppImages.assetsIconsDollerIcon,
        'text': 'Bluetooth',
        'label': 'Connectivity'
      },
    ];

    return Container(
      margin: EdgeInsets.only(top: 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: features.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: AppColors.neutral100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCircleImage(
                  imagePath: features[index]['icon']!,
                  radius: 16,
                ),
                SizedBox(height: 30),
                Flexible(
                  child: Text(
                    features[index]['label']!,
                    style: AppTextStyles.bodySmall(color: AppColors.neutral400),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  child: Text(
                    features[index]['text']!,
                    style: AppTextStyles.bodySmall(color: AppColors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}