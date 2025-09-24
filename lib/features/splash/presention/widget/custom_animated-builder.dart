import 'package:car_app/core/utils/app_color.dart';
import 'package:flutter/material.dart';

class CustomAnimateBuilder extends StatelessWidget {
  const CustomAnimateBuilder({
    super.key,
    required AnimationController progressController,
    required Animation<double> progressValue,
    required String loadingText,
  }) : _progressController = progressController, _progressValue = progressValue, _loadingText = loadingText;

  final AnimationController _progressController;
  final Animation<double> _progressValue;
  final String _loadingText;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _progressController,
      builder: (context, child) {
        return Column(
          children: [
            Container(
              width: 280,
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.grey.shade300,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: _progressValue.value,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.neutral900, 
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: Text(
                _loadingText,
                key: ValueKey(_loadingText),
                style: TextStyle(
                  color: AppColors.neutral900, 
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }
}

