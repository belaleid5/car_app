import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/services/server_locator.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/manger/car_details_cubit.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/manger/car_details_state.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/widgets/custom_app_bar_detils_screen.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/widgets/slider_cars_secation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarDetailsScreen extends StatelessWidget {
  const CarDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int carId = args['carId'] as int;
    final String? imageUrl = args['imageUrl'] as String?;

    return BlocProvider(
      create: (context) => sl<CarCubit>()
        ..getCarById(carId)
        ..getReviewCarById(carId),
      child: Scaffold(
        backgroundColor: AppColors.neutral100.withOpacity(0.9),
        body: CustomScrollView(
          slivers: [
            CustomAppBarDetailsScreen(),
            SliverToBoxAdapter(
              child: BlocBuilder<CarCubit, CarState>(
                builder: (context, state) {
                  if (state.carDetailsStatus == AppStatus.loading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (state.carDetailsStatus == AppStatus.failure) {
                    return Center(
                        child: Text('Error: ${state.carDetailsError}'));
                  }

                  if (state.selectedCar != null) {
                    return SliderCarsSection(
                      car: state.selectedCar!,
                      fallbackImageUrl: imageUrl,
                    );
                  }

                  return SizedBox.shrink();
                },
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            SliverToBoxAdapter(
              child: BlocBuilder<CarCubit, CarState>(
                builder: (context, state) {
                  return Container(
                    alignment: Alignment.topLeft,
                    height: res.hp(200),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  state.selectedCar?.name ?? 'Unknown Car',
                                  style:
                                      AppTextStyles.h5(color: AppColors.black),
                                ),
                                SizedBox(
                                  width: res.wp(75),
                                  child: Text(
                                    state.selectedCar?.description ??
                                        'Unknown Brand',
                                    overflow: TextOverflow.visible,
                                    style: AppTextStyles.bodyMedium(
                                        color: AppColors.neutral400),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  state.carsByReview?.review ?? '0.0',
                                  style: AppTextStyles.bodyMedium(
                                      color: AppColors.neutral400),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
