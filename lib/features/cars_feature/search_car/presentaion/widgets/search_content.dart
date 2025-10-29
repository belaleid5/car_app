import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_images.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/core/widget/cusom_scircular_image_svg.dart';
import 'package:car_app/features/cars_feature/home/presentaion/widget/custom_search_form.dart';
import 'package:car_app/features/cars_feature/home/presentaion/widget/custom_title_and_view_all.dart';
import 'package:car_app/features/cars_feature/search_car/presentaion/manger/search_cubit.dart';
import 'package:car_app/features/cars_feature/search_car/presentaion/widgets/card_our_popular_cars.dart';
import 'package:car_app/features/cars_feature/search_car/presentaion/widgets/card_rental_car.dart';
import 'package:car_app/features/cars_feature/search_car/presentaion/widgets/custom_list_brand.dart';
import 'package:car_app/features/cars_feature/search_car/presentaion/widgets/filter_search_card.dart';
import 'package:car_app/features/cars_feature/search_car/presentaion/widgets/search_result_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreenContent extends StatelessWidget {
  const SearchScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return  CustomScrollView(
        slivers: [
          // AppBar
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.white,
            leading: CustomCircleImage(
              radius: 15,
              imagePath: AppImages.iconBack,
              height: 15,
            ),
            centerTitle: true,
            title: Text(
              'Search',
              style: AppTextStyles.h6(
                color:AppColors.black,
              ),
            ),
            actions: [
              CustomCircleImage(
                imagePath: AppImages.threeDotsIcon,
                radius: 25,
              ),
            ],
          ),

          // Divider
          SliverToBoxAdapter(
            child: Divider(
              color: AppColors.neutral200,
              height: 1,
            ),
          ),

          // Search Bar & Filter Button
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    child: CustomSearchForm(
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (bottomSheetContext) => BlocProvider.value(
                          value: context.read<SearchCubit>(),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.85,
                            child: const CarFiltersScreen(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.tune,
                        color: AppColors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Brand List
          const SliverToBoxAdapter(
            child: CustomListBrand(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),

          // Results Section
          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              // Loading State
              if (state.appStatus == AppStatus.loading) {
                return const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              // Error State
              if (state.appStatus == AppStatus.failure) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 60,
                          color: AppColors.error600,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.message ?? 'Something went wrong',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<SearchCubit>().getAllCars();
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              // عرض نتائج البحث إذا كانت موجودة
              if (state.responsePaginationSearchCars != null) {
                final cars = state.responsePaginationSearchCars!.cars;

                if (cars.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 80,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No cars found',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Try adjusting your filters',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Found ${cars.length} cars',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }

                        final car = cars[index - 1];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: SearchResultCard(
                            carName: car.name,
                            brand: car.brand.name,
                            rating: car.reviewsAvg,
                            location: car.location.name,
                            pricePerDay: car.dailyRent != null
                                ? int.tryParse(car.dailyRent!) ?? 0
                                : (car.price != null
                                    ? int.tryParse(car.price!) ?? 0
                                    : 0),
                            imageUrl: car.firstImage,
                            color: car.color.name,
                            seatingCapacity:
                                int.tryParse(car.seatingCapacity) ?? 4,
                            fuelType: car.carType,
                          ),
                        );
                      },
                      childCount: cars.length + 1,
                    ),
                  ),
                );
              }

              // عرض جميع السيارات (الحالة الافتراضية)
              if (state.allCars != null) {
                final allCars =
                    state.allCars!.expand((page) => page.cars).toList();

                return SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: CustomTitleAndViewAll(title: "Recommend For You"),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: ResponsiveHelper(context).heightPercent(35),
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: allCars.length > 6 ? 6 : allCars.length,
                        itemBuilder: (context, index) {
                          final car = allCars[index];
                          return CarRentalCard(
                            carModel: car.name,
                            rating: car.reviewsAvg,
                            location: car.location.name,
                            pricePerDay: car.dailyRent != null
                                ? int.tryParse(car.dailyRent!) ?? 0
                                : (car.price != null
                                    ? int.tryParse(car.price!) ?? 0
                                    : 0),
                            imageUrl: car.firstImage,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: CustomTitleAndViewAll(title: "Our Popular Cars"),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: ResponsiveHelper(context).heightPercent(15),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 15),
                        itemCount: allCars.length > 5 ? 5 : allCars.length,
                        itemBuilder: (context, index) {
                          final car = allCars[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: CardOurPopularCars(
                              carName: car.name,
                              rating: car.reviewsAvg,
                              location: car.location.name,
                              pricePerDay: car.dailyRent != null
                                  ? int.tryParse(car.dailyRent!) ?? 0
                                  : (car.price != null
                                      ? int.tryParse(car.price!) ?? 0
                                      : 0),
                              imageUrl: car.firstImage,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ]),
                );
              }

              return const SliverFillRemaining(
                child: Center(child: Text('No data available')),
              );
            },
          ),
        ],
    
    );
  }
}








