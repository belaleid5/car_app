import 'package:car_app/core/shared/brands_entity.dart';
import 'package:car_app/core/widget/custom_item_brand.dart';
import 'package:flutter/material.dart';

class CustomListBrandItem extends StatelessWidget {
  const CustomListBrandItem({
    super.key,
    required this.brandsList,
    required this.isLoading,
    required this.selectedIndex,
    required this.onTap,
    required this.itemCount,
  });

  final List<BrandEntity> brandsList;
  final bool isLoading;
  final int? selectedIndex;
  final Function(int) onTap;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: itemCount,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemBuilder: (context, index) {
        final brand = brandsList[index];
        final isSelected = !isLoading && selectedIndex == index;

        return GestureDetector(
          onTap: () => onTap(index),
          child: CustomItemBrand(
            isSelected: isSelected,
            brand: brand,
          ),
        );
      },
    );
  }
}