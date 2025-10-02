import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/services/server_locator.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_images.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/core/widget/cusom_scircular_image_svg.dart';
import 'package:car_app/core/widget/custom_title_secation.dart';
import 'package:car_app/features/home/presentaion/manger/home_cubit.dart';
import 'package:car_app/features/home/presentaion/widget/best_cars_section.dart';
import 'package:car_app/features/home/presentaion/widget/custom_app_bar_home.dart';
import 'package:car_app/features/home/presentaion/widget/custom_best_cars.dart';
import 'package:car_app/features/home/presentaion/widget/custom_lis_brand.dart';
import 'package:car_app/features/home/presentaion/widget/custom_search_form.dart';
import 'package:car_app/features/home/presentaion/widget/custom_title_and_view_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


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
                BestCarsSection(),
                ],
            ),
          ),
        ),
      ),
    );
  }
}
