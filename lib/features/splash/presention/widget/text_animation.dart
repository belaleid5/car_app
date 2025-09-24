import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:flutter/material.dart';

class TextAinmation extends StatelessWidget {
  const TextAinmation({
    super.key,
    required Animation<Offset> textSlide,
    required Animation<double> textOpacity,
  }) : _textSlide = textSlide, _textOpacity = textOpacity;

  final Animation<Offset> _textSlide;
  final Animation<double> _textOpacity;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _textSlide,
      child: FadeTransition(
        opacity: _textOpacity,
        child: Column(
          children: [
            Text(
              'Car Rental',
              style: AppTextStyles.bodyLarge().copyWith(
                color: AppColors.neutral900, 
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Rent Your Perfect Car',
              style: AppTextStyles.bodyLarge().copyWith(
                color: AppColors.neutral700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}