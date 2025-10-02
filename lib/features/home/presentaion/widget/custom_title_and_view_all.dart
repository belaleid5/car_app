import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/core/widget/custom_title_secation.dart';
import 'package:flutter/material.dart';

class CustomTitleAndViewAll extends StatelessWidget {
  const CustomTitleAndViewAll({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTitleSection(
          title: title,
        ),
        Text(
          "View All",
          style: AppTextStyles.caption(),
        )
      ],
    );
  }
}