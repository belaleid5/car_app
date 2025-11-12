import 'package:car_app/core/dummy_data/dummy_list_brand.dart';
import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/widget/custom_shimmer_widget.dart';
import 'package:car_app/features/cars_feature/home/presentaion/manger/home_cubit.dart';
import 'package:car_app/features/cars_feature/home/presentaion/manger/home_state.dart';
import 'package:car_app/features/cars_feature/home/presentaion/widget/custom_list_home_brands.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSectionHomeBrands extends StatefulWidget {
  const CustomSectionHomeBrands({
    super.key,
    required this.res,
  });

  final ResponsiveHelper res;

  @override
  State<CustomSectionHomeBrands> createState() =>
      _CustomSectionHomeBrandsState();
}

class _CustomSectionHomeBrandsState extends State<CustomSectionHomeBrands> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().refreshBrands();
  }

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.status == AppStatus.loading && state.brands.isEmpty) {
          final dummyBrands = DummiesData().dummyBrandItem();

          return CustomShimmerWidget(
              shimmerWidget: CustomListHomeBrands(
            res: res,
            state: state,
            brandsList: dummyBrands,
            isLoading: true,
            onTap: (int p1) {},
            itemCount: dummyBrands.length,
          ));
        } else {
          return CustomListHomeBrands(
            res: res,
            state: state,
            brandsList: state.brands,
            isLoading: false,
            onTap: (int p1) {},
            itemCount: state.brands.length,
          );
        }
      },
    );
  }
}


