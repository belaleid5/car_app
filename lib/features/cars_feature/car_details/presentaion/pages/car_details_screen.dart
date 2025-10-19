import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/services/server_locator.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/manger/car_details_cubit.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/manger/car_details_state.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/widgets/custom_app_bar_detils_screen.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/widgets/cutom_details_review_sevction.dart';
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
      create: (context) => sl<ReviewsCubit>()..loadCarDetails(carId),
      child: Scaffold(
        // ignore: deprecated_member_use
        backgroundColor: AppColors.neutral100.withOpacity(0.9),
        body: CustomScrollView(
          slivers: [
            CustomAppBarDetailsScreen(),
            SliverToBoxAdapter(
              child: BlocBuilder<ReviewsCubit, ReviewsState>(
                builder: (context, state) {
                  if (state.selectedCar == null) {
                    return Container(
                      height: res.hp(250),
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        color: AppColors.neutral900,
                      ),
                    );
                  }

                  return SliderCarsSection(
                    fallbackImageUrl: imageUrl,
                    car: state.selectedCar,
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            SliverToBoxAdapter(
              child: CustomDetailsReviewSection(res: res),
            ),
          ],
        ),
      ),
    );
  }
}











