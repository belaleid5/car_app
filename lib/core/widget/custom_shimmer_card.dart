 import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerCard extends StatelessWidget {
   const CustomShimmerCard({super.key, required this.res});
 

 final ResponsiveHelper res;
   @override
   Widget build(BuildContext context) {
     return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: res.hp(100),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: res.hp(32),
                      width: double.infinity,
                      color: Colors.grey[300]),
                  const SizedBox(height: 8),
                  Container(height: 12, width: 60, color: Colors.grey[300]),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(height: 10, width: 80, color: Colors.grey[300]),
                      const Spacer(),
                      Container(height: 10, width: 40, color: Colors.grey[300]),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(height: 14, width: 100, color: Colors.grey[300]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
   }
 }