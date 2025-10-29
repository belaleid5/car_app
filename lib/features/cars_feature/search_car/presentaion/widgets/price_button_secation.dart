import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:flutter/material.dart';

class PriceAndButtonSection extends StatelessWidget {
  final int pricePerDay;
  final Function()? onBookTap;

  const PriceAndButtonSection({
    super.key,
    required this.pricePerDay,
    this.onBookTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        top: 5,
        right: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '\$$pricePerDay/Day',
            style: AppTextStyles.labelSmall(
              color: AppColors.neutral800,
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: onBookTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
            ),
            child: Text(
              'Book now',
              style: AppTextStyles.labelSmall(
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}