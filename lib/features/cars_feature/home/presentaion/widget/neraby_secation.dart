import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_images.dart';
import 'package:car_app/features/cars_feature/home/presentaion/manger/home_cubit.dart';
import 'package:car_app/features/cars_feature/home/presentaion/manger/home_state.dart';
import 'package:car_app/features/cars_feature/home/presentaion/widget/custom_title_and_view_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NearbyCarsSection extends StatefulWidget {
  const NearbyCarsSection({super.key});

  @override
  State<NearbyCarsSection> createState() => _NearbyCarsSectionState();
}

class _NearbyCarsSectionState extends State<NearbyCarsSection> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchNearestCars(3);
  }

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return ColoredBox(
      color: AppColors.white,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                const CustomTitleAndViewAll(title: "Nearby"),
                if (state.status == AppStatus.failure)
                  _buildErrorState(res)
                else if (state.nearestCars.isEmpty)
                  _buildEmptyState(res)
                else
                  _buildCarCard(state.nearestCars.first, res),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCarCard(dynamic car, ResponsiveHelper res) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            height: res.screenHeight * 0.2,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.neutral200,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                car.mainImageUrl ?? '',
                width: res.screenWidth * 0.334,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    car.images.isNotEmpty
                        ? car.images.first as String
                        : AppImages.white_car,
                    width: res.screenWidth * 0.334,
                    fit: BoxFit.fill,
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 32,
            right: 12,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.favorite_border,
                  color: Colors.black, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(ResponsiveHelper res) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      height: res.screenHeight * 0.2,
      width: res.screenWidth * 0.9,
      decoration: BoxDecoration(
        color: AppColors.neutral200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.error_outline, size: 40, color: Colors.grey),
            SizedBox(height: 8),
            Text(
              'Failed to load nearby cars',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(ResponsiveHelper res) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      height: res.screenHeight * 0.2,
      width: res.screenWidth * 0.9,
      decoration: BoxDecoration(
        color: AppColors.neutral200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.directions_car_outlined, size: 40, color: Colors.grey),
            SizedBox(height: 8),
            Text(
              'No nearby cars available',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
