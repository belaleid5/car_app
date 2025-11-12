import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/services/server_locator.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_images.dart';
import 'package:car_app/core/widget/cusom_scircular_image_svg.dart';
import 'package:car_app/core/widget/custom_title_secation.dart';
import 'package:car_app/features/cars_feature/home/presentaion/manger/home_cubit.dart';
import 'package:car_app/features/cars_feature/home/presentaion/widget/best_cars_section.dart';
import 'package:car_app/features/cars_feature/home/presentaion/widget/custom_app_bar_home.dart';
import 'package:car_app/features/cars_feature/home/presentaion/widget/custom_lis_brand.dart';
import 'package:car_app/features/cars_feature/home/presentaion/widget/custom_search_form.dart';
import 'package:car_app/features/cars_feature/home/presentaion/widget/neraby_secation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  // optional
  final String? imagePath; // optional
  final String? idImage;

  const HomeScreen({
    super.key,
    this.imagePath, // ✅ مش required
    this.idImage, // ✅ مش required
  });

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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 15),
                    child: Row(
                      children: [
                        Expanded(child: CustomSearchForm()),
                        const SizedBox(width: 8),
                        FittedBox(
                          child: CustomCircleImage(
                            imagePath: AppImages.assetsIconsFilterIcon,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10),
                    child: CustomTitleSection(
                      title: "Brands",
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: CustomSectionHomeBrands(res: res),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: 15),
                ),
                BestCarsSection(),
                SliverToBoxAdapter(
                  child: NearbyCarsSection(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
