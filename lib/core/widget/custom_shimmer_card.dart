import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:flutter/material.dart';

class CustomShimmerCard extends StatelessWidget {
  const CustomShimmerCard({super.key, required this.res});

  final ResponsiveHelper res;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: res.screenWidth * 0.75, // حجم مناسب للعرض الأفقي
      margin: const EdgeInsets.only(right: 12), // مسافة بين الكروت
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة أو مساحة علوية
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
            ),
          ),

          // نصوص تحت الصورة
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: 6),
                Text(
                  "Car Model Name",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Brand Name",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "\$25,000",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "New",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
