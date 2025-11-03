import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/features/cars_feature/home/presentaion/manger/home_cubit.dart';
import 'package:car_app/features/cars_feature/home/presentaion/manger/home_state.dart';
import 'package:car_app/features/cars_feature/search_car/presentaion/manger/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomListBrand extends StatefulWidget {
  const CustomListBrand({super.key});

  @override
  State<CustomListBrand> createState() => _CustomListBrandState();
}

class _CustomListBrandState extends State<CustomListBrand> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.status != AppStatus.success || state.brands.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final uniqueBrands = state.brands.fold<List<dynamic>>([], (list, brand) {
            if (!list.any((b) => b.name == brand.name)) list.add(brand);
            return list;
          });

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: uniqueBrands.length,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemBuilder: (context, index) {
              final brand = uniqueBrands[index];
              final isSelected = selectedIndex == index;

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() => selectedIndex = index);
                  context.read<HomeCubit>().fetchBrands();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  width: isSelected ? 130 : 100,
                  margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.black : AppColors.neutral100,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      width: 1,
                      color: isSelected ? AppColors.neutral300 : Colors.transparent,
                    ),
                    boxShadow: [
                      if (isSelected)
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (brand.image.isNotEmpty)
                        CircleAvatar(
                          radius: isSelected ? 18 : 15,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(brand.image),
                          onBackgroundImageError: (_, __) {},
                          child: const Icon(Icons.image, size: 16),
                        ),
                      if (brand.image.isNotEmpty) const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          brand.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: isSelected ? 13 : 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}