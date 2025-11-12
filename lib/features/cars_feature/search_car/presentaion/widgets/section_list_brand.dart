import 'package:car_app/core/dummy_data/dummy_list_brand.dart';
import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/widget/custom_list_brand_item.dart';
import 'package:car_app/core/widget/custom_shimmer_widget.dart';
import 'package:car_app/features/cars_feature/home/presentaion/manger/home_cubit.dart';
import 'package:car_app/features/cars_feature/home/presentaion/manger/home_state.dart';
import 'package:car_app/features/cars_feature/search_car/presentaion/manger/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionListBrand extends StatefulWidget {
  const SectionListBrand({super.key});

  @override
  State<SectionListBrand> createState() => _SectionListBrandState();
}

class _SectionListBrandState extends State<SectionListBrand> {
  int? selectedIndex;

  @override
  void initState() {
    context.read<HomeCubit>().fetchBrands();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, brandsState) {
          final isLoading = brandsState.status == AppStatus.loading;
          final brandsList = brandsState.brands;
          final displayList = brandsList;
          final dummyBrands = DummiesData().dummyBrandItem();

          if (brandsList.isEmpty && !isLoading) {
            return CustomShimmerWidget(
              shimmerWidget: CustomListBrandItem(
                itemCount: dummyBrands.length,
                brandsList: dummyBrands,
                isLoading: true,
                selectedIndex: selectedIndex,
                onTap: (index) {},
              ),
            );
          } else {
            return CustomListBrandItem(
              itemCount: displayList.length,
              brandsList: displayList,
              isLoading: isLoading,
              selectedIndex: selectedIndex,
              onTap: (index) {
                if (!isLoading) {
                  final isSelected = selectedIndex == index;
                  setState(() => selectedIndex = isSelected ? null : index);
                  if (isSelected) {
                    context.read<SearchCubit>().clearFilter();
                  } else {
                    context
                        .read<SearchCubit>()
                        .filterByBrand(displayList[index].id);
                  }
                }
              },
            );
          }
        },
      ),
    );
  }
}





