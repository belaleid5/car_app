import 'package:car_app/core/dummy_data/dummy_list_brand.dart';
import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/core/widget/custom_shimmer_widget.dart';
import 'package:car_app/features/cars_feature/home/presentaion/manger/home_cubit.dart';
import 'package:car_app/features/cars_feature/home/presentaion/manger/home_state.dart';
import 'package:car_app/features/cars_feature/home/presentaion/widget/custom_list_cars.dart';
import 'package:car_app/features/cars_feature/home/presentaion/widget/custom_title_and_view_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTitleAndViewAll(title: "Best Cars"),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text("Available", style: AppTextStyles.caption()),
            ),
            const SizedBox(height: 12),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
              if (state.bestCars.isEmpty &&
                    state.status == AppStatus.loading) {
                  return CustomShimmerWidget(
                    shimmerWidget: CustomListCars(
                      favorite: true,
                      isLoading: true,
                      cars: DummiesData().dummyDataCars()));
                }else{
                return CustomListCars(
                  
                  cars: state.bestCars);

                }

              },    
            ),
          ],
        ),
      ),
    );
  }
}
/*  */