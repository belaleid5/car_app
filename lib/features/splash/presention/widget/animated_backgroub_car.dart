import 'package:car_app/features/splash/presention/widget/paint_car.dart';
import 'package:flutter/material.dart';

class AnimatedCarBackground extends StatelessWidget {
  final Animation<double> backgroundAnimation;
  
  const AnimatedCarBackground({Key? key, required this.backgroundAnimation})
      : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: backgroundAnimation,
      builder: (context, child) {
        return CustomPaint(
          painter: CarBackgroundPainter(backgroundAnimation.value),
          size: Size.infinite,
        );
      },
    );
  }
}

