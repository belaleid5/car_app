// best_cars_section.dart
import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_images.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/features/home/presentaion/manger/home_cubit.dart';
import 'package:car_app/features/home/presentaion/manger/home_state.dart';
import 'package:car_app/features/home/presentaion/widget/custom_best_cars.dart';
import 'package:car_app/features/home/presentaion/widget/custom_title_and_view_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BestCarsSection extends StatefulWidget {
  const BestCarsSection({super.key});

  @override
  State<BestCarsSection> createState() => _BestCarsSectionState();
}

class _BestCarsSectionState extends State<BestCarsSection> {
    @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchBestCars();
  }
  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);

    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTitleAndViewAll(
              title: "Best Cars",
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "Available",
                style: AppTextStyles.caption(),
              ),
            ),
            SizedBox(height: 12),

            // ✨ BLoC Builder للسيارات
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                // Loading State
                if (state.status == AppStatus.loading &&
                    state.bestCars.isEmpty) {
                  return _buildLoadingState(res);
                }

                // Error State
                if (state.status == AppStatus.failure &&
                    state.bestCars.isEmpty) {
                  return _buildErrorState(state.errorMessage, context);
                }

                // Empty State
                if (state.bestCars.isEmpty) {
                  return _buildEmptyState(res);
                }

                // Success State
                return _buildCarsList(state, res, context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState(ResponsiveHelper res) {
    return SizedBox(
      height: res.screenHeight * 0.38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        padding: EdgeInsets.symmetric(horizontal: 4),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SizedBox(
              width: res.screenWidth * 0.45,
              child: _buildShimmerCard(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildShimmerCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral300.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.neutral900,
        ),
      ),
    );
  }

  Widget _buildErrorState(String? errorMessage, BuildContext context) {
    return Container(
      height: 200,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: AppColors.error100,
          ),
          SizedBox(height: 16),
          Text(
            errorMessage ?? 'Failed to load cars',
            style: AppTextStyles.bodyMedium(),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<HomeCubit>().refreshBestCars();
            },
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ResponsiveHelper res) {
    return Container(
      height: res.screenHeight * 0.38,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.directions_car_outlined,
            size: 64,
            color: AppColors.neutral500,
          ),
          SizedBox(height: 16),
          Text(
            'No cars available',
            style: AppTextStyles.labelMedium(),
          ),
        ],
      ),
    );
  }

  Widget _buildCarsList(
      HomeState state, ResponsiveHelper res, BuildContext context) {
    return SizedBox(
      height: res.screenHeight * 0.38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.bestCars.length + (state.hasReachedMax ? 0 : 1),
        padding: EdgeInsets.symmetric(horizontal: 4),
        itemBuilder: (context, index) {
          // Loading More Indicator
          if (index >= state.bestCars.length) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.neutral900,
                ),
              ),
            );
          }

          final car = state.bestCars[index];

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SizedBox(
              width: res.screenWidth * 0.45,
              child: CustomCardBestCars(
                carImage: car.image,
                carName: car.name,
                rating: car.averageRate,
                location: car.location.name,
                seats: car.seatingCapacity.toString(),
                pricePerDay: car.isForRent && car.dailyRent != null
                    ? '/${car.dailyRent!.toStringAsFixed(0)}/day'
                    : car.isForPay && car.price != null
                        ? '\$${car.price!.toStringAsFixed(0)}'
                        : 'Contact',
                heartIconPath: AppImages.heartIcon,
                locationIconPath: AppImages.assetsIconsMapIcon,
                seatIconPath: AppImages.assetsIconsSeatIcon,
                dollarIconPath: AppImages.assetsIconsDollerIcon,
                onTap: () {},
              ),
            ),
          );
        },
      ),
    );
  }
}
