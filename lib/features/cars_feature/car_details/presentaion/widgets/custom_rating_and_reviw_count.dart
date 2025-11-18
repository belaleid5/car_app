import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_images.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/manger/dateils_cubit.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/manger/deatils_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CustomRatingAndReviewCount extends StatelessWidget {
  const CustomRatingAndReviewCount({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsCubit, DetailsState>(
      builder: (context, state) {
        if (state.status == AppStatus.failure) {
          return Text("Error Fetch Data Rating");
        }
        if (state.status == AppStatus.success) {
          return Column(
            children: [
              FittedBox(
                child: Row(
                  children: [
                    Text(
                      "${state.allReviews ?? '0.0'}",
                      style: AppTextStyles.bodyMedium(color: AppColors.black),
                    ),
                    SizedBox(width: 5),
                    SvgPicture.asset(
                      AppImages.starIcon,
                      width: 16,
                      height: 16,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text(
                "${state.allReviews?.length ?? '0'}",
                style: AppTextStyles.bodySmall(color: AppColors.neutral400),
              ),
            ],
          );
        }
        return SizedBox();
      },
    );
  }
}