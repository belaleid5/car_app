import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/features/cars_feature/home/domain/entity/brands_entity.dart';
import 'package:car_app/features/cars_feature/home/presentaion/manger/home_state.dart';
import 'package:car_app/features/cars_feature/home/presentaion/widget/custom_item_brand_home.dart';
import 'package:flutter/material.dart';

class CustomListHomeBrands extends StatefulWidget {
  const CustomListHomeBrands({
    super.key,
    required this.res,
    required this.state,
    required this.brandsList,
    required this.isLoading,
    this.selectedIndex,
    required this.onTap,
    required this.itemCount,
  });

  final ResponsiveHelper res;
  final HomeState state;
  final List<BrandEntity> brandsList;
  final bool isLoading;
  final int? selectedIndex;
  final Function(int) onTap;
  final int itemCount;

  @override
  State<CustomListHomeBrands> createState() => _CustomListHomeBrandsState();
}

class _CustomListHomeBrandsState extends State<CustomListHomeBrands> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: widget.res.screenHeight * 0.15,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: widget.itemCount,
          separatorBuilder: (context, index) =>
              SizedBox(width: widget.res.wp(6)),
          itemBuilder: (context, index) {
            final brand = widget.brandsList[index];
            return CustomItemBrandHome(brand: brand);
          },
        ),
      ),
    );
  }
}
