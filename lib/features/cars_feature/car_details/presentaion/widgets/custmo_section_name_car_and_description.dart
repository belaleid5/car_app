import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/manger/car_details_cubit.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/manger/car_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSectionNameCarAndDescription extends StatelessWidget {
  const CustomSectionNameCarAndDescription({
    super.key,
    required this.res,
  });

  final ResponsiveHelper res;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsCubit, ReviewsState>(
      builder: (context, state) {
        if (state.status == AppStatus.failure) {
          return Center(
            child: Text(
              state.errorMessage ?? 'Failed to load data',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        if (state.status == AppStatus.success) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.selectedCar?.name ?? 'Car Name',
                style: AppTextStyles.h5(color: AppColors.black),
              ),
              SizedBox(
                width: res.wp(62),
                child: Text(
                  state.selectedCar?.description ??
                      'A car with high specs that are rented at an affordable price.',
                  overflow: TextOverflow.visible,
                  style: AppTextStyles.labelSmall(color: AppColors.neutral400),
                ),
              ),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
