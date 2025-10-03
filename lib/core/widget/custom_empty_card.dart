import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:flutter/material.dart';

class CustomEmptyCard extends StatelessWidget {
  const CustomEmptyCard({super.key, required this.res});

final ResponsiveHelper res;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: res.hp(250),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.directions_car_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No cars available'),
          ],
        ),
      ),
    );
  }
}