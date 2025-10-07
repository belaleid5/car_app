import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_images.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSearchForm extends StatefulWidget {
  const CustomSearchForm({super.key});

  @override
  State<CustomSearchForm> createState() => _CustomSearchFormState();
}

class _CustomSearchFormState extends State<CustomSearchForm> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 0.2,
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SvgPicture.asset(AppImages.assetsIconsSearchIcon),
            ),
            Expanded(
              child: TextField(
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: 'Search your dream car...',
                  hintStyle:
                      AppTextStyles.bodySmall(color: AppColors.neutral300),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 8,
                  ),
                ),
                style: AppTextStyles.bodySmall(color: AppColors.neutral800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}