import 'package:car_app/core/utils/app_text.dart';
import 'package:flutter/material.dart';

class CustomTitleSection extends StatelessWidget {
  const CustomTitleSection({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Text(
        title,
        style: AppTextStyles.bodyMedium().copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

