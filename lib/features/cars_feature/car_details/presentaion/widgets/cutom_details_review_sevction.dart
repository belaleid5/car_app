import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/core/widget/cutsom_eleveted_button.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/manger/dateils_cubit.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/manger/deatils_state.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/widgets/custmo_section_name_car_and_description.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/widgets/custom_card_review.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/widgets/custom_rating_and_reviw_count.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/widgets/custom_user_data.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/widgets/features_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class CustomDetailsReviewSection extends StatelessWidget {
  const CustomDetailsReviewSection({
    super.key,
    required this.res,
  });

  final ResponsiveHelper res;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsCubit, DetailsState>(
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
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomSectionNameCarAndDescription(res: res),
                    SizedBox(width: 8),
                    CustomRatingAndReviewCount(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Divider(
                    color: AppColors.neutral400.withOpacity(0.6),
                    thickness: 1,
                  ),
                ),
                CustomUserData(),
                SizedBox(height: 20),
                Text("Car Features",
                    style: AppTextStyles.h6(color: AppColors.black)),
                FeaturesGridView(res: res),
                SizedBox(height: 20),
                Text("Review (125)", style: AppTextStyles.bodySmall()),
                SizedBox(height: 20),
                CardReview(),
                SizedBox(height: 8),
                CustomElevatedButton(
                  res: res,
                  titleColor: AppColors.white,
                  buttonColor: AppColors.neutral900,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Book Now"), 
                      Icon(Icons.arrow_forward)],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}