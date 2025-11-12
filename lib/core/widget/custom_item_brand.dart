import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/features/cars_feature/home/domain/entity/brands_entity.dart';
import 'package:flutter/material.dart';

class CustomItemBrand extends StatelessWidget {
  const CustomItemBrand({
    super.key,
    required this.isSelected,
    required this.brand,
  });

  final bool isSelected;
  final BrandEntity brand;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: isSelected ? 130 : 100,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.neutral900 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: isSelected ? AppColors.neutral900 : Colors.grey.shade300,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: AppColors.neutral900.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: isSelected ? 18 : 15,
            backgroundColor: Colors.transparent,
            child: brand.image.isNotEmpty
                ? Image.network(
                    brand.image,
                    width: isSelected ? 30 : 25,
                    height: isSelected ? 30 : 25,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.directions_car,
                      size: isSelected ? 30 : 25,
                      color: Colors.grey.shade400,
                    ),
                  )
                : Icon(
                    Icons.directions_car,
                    size: isSelected ? 30 : 25,
                    color: Colors.grey.shade400,
                  ),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              brand.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isSelected ? AppColors.white : AppColors.neutral900,
                fontWeight: FontWeight.w600,
                fontSize: isSelected ? 13 : 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
