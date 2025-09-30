import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/services/server_locator.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_images.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/core/widget/cusom_scircular_image_svg.dart';
import 'package:car_app/core/widget/custom_title_secation.dart';
import 'package:car_app/features/home/presentaion/manger/home_cubit.dart';
import 'package:car_app/features/home/presentaion/widget/custom_app_bar_home.dart';
import 'package:car_app/features/home/presentaion/widget/custom_best_cars.dart';
import 'package:car_app/features/home/presentaion/widget/custom_lis_brand.dart';
import 'package:car_app/features/home/presentaion/widget/custom_search_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return BlocProvider(
      create: (context) => sl<HomeCubit>(),
      child: Scaffold(
          backgroundColor: AppColors.neutral100,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 28),
              child: CustomScrollView(
                slivers: [
                  CustomAppBarHome(res: res),
                  SliverToBoxAdapter(
                    child: Divider(
                      color: AppColors.neutral200,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Expanded(child: CustomSearchForm()),
                          const SizedBox(width: 8),
                          FittedBox(
                              child: CustomCircleImage(
                            imagePath: AppImages.assetsIconsFilterIcon,
                          )),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: CustomTitleSection(
                      title: "Brands",
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: CustomListBrand(res: res),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 20),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
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
                          SizedBox(
                            height: res.screenHeight * 0.38,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 10,
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: SizedBox(
                                    width: res.screenWidth * 0.45,
                                    child: CustomCardBestCars(
                                      carImage: AppImages.white_car,
                                      carName: 'Ferrari',
                                      rating: 4.8,
                                      location: 'Cairo',
                                      seats: '4',
                                      pricePerDay: '/200/day',
                                      heartIconPath: AppImages.heartIcon,
                                      locationIconPath:
                                          AppImages.assetsIconsMapIcon,
                                      seatIconPath: AppImages.assetsIconsSeatIcon,
                                      dollarIconPath:
                                          AppImages.assetsIconsDollerIcon,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          CustomTitleAndViewAll(
                            title: "Nearby",
                          ),
                          Container(
                            height: res.screenHeight * 0.150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: AppColors.neutral200,
                                borderRadius: BorderRadius.circular(12)),
                            child: Image.asset(
                              AppImages.white_car,
                              fit: BoxFit.fitHeight,
                              width: res.widthPercent(334),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}

class CustomTitleAndViewAll extends StatelessWidget {
  const CustomTitleAndViewAll({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTitleSection(
          title: title,
        ),
        Text(
          "View All",
          style: AppTextStyles.caption(),
        )
      ],
    );
  }
}
