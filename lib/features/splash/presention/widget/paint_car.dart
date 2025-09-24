import 'dart:math';

import 'package:flutter/material.dart';

class CarBackgroundPainter extends CustomPainter {
  final double animationValue;
  final Random random = Random();
  
  CarBackgroundPainter(this.animationValue);
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1;
    
    for (int i = 0; i < 8; i++) {
      final y = (size.height / 8 * i + animationValue * 50) % size.height;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
    
    final wheelPaint = Paint()
      ..color = Colors.white.withOpacity(0.03);
      
    for (int i = 0; i < 15; i++) {
      final x = (random.nextDouble() * size.width + 
               animationValue * 30) % size.width;
      final y = (random.nextDouble() * size.height + 
               animationValue * 20) % size.height;
      
      canvas.drawCircle(
        Offset(x, y),
        random.nextDouble() * 8 + 3,
        wheelPaint,
      );
    }
  }
  
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}


