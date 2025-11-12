import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/services/server_locator.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_images.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/core/widget/cusom_scircular_image_svg.dart';
import 'package:car_app/features/cars_feature/home/presentaion/manger/home_cubit.dart';
import 'package:car_app/features/cars_feature/home/presentaion/widget/custom_search_form.dart';
import 'package:car_app/features/cars_feature/home/presentaion/widget/custom_title_and_view_all.dart';
import 'package:car_app/features/cars_feature/search_car/presentaion/manger/search_cubit.dart';
import 'package:car_app/features/cars_feature/search_car/presentaion/widgets/car_card.dart';
import 'package:car_app/features/cars_feature/search_car/presentaion/widgets/section_list_brand.dart';
import 'package:car_app/features/cars_feature/search_car/presentaion/widgets/search_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) => BlocProvider.value(
        value: context.read<SearchCubit>(),
        child: CarFilterScreen(
          initialFilter: context.read<SearchCubit>().state.currentFilter,
          onApplyFilter: (filter) {
            context.read<SearchCubit>().applyFilter(filter);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchCubit>(
          create: (context) => sl<SearchCubit>()..getAllCars(),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => sl<HomeCubit>(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.neutral100,
            body: CustomScrollView(
              slivers: [
                // App Bar
                SliverAppBar(
                  pinned: true,
                  backgroundColor: Colors.white,
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomCircleImage(
                      imagePath: AppImages.iconBack,
                      height: 15,
                    ),
                  ),
                  centerTitle: true,
                  title: Text('Search',
                      style: AppTextStyles.h6(color: AppColors.black)),
                  actions: [
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: AppColors.neutral400, width: 0.3),
                      ),
                      child:
                          Icon(Icons.more_horiz, color: AppColors.neutral400),
                    ),
                  ],
                ),

                SliverToBoxAdapter(
                    child: Divider(color: AppColors.neutral200, height: 1)),

                // Search Bar with Filter Button
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Expanded(child: CustomSearchForm(onTap: () {})),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => _showFilterBottomSheet(context),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.black,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.tune,
                                color: Colors.white, size: 24),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Brand Filter List
                SliverToBoxAdapter(child: SectionListBrand()),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),

                // Recommend For You Title
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: CustomTitleAndViewAll(title: "Recommend For You"),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 10)),

                // Cars Grid
                BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state.appStatus == AppStatus.failure) {
                      return SliverFillRemaining(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.error_outline,
                                  size: 64, color: Colors.red),
                              const SizedBox(height: 16),
                              Text(state.message ?? 'Failed to load cars'),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () => context
                                    .read<SearchCubit>()
                                    .getAllCars(isRefresh: true),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black),
                                child: const Text('Retry',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final cars = state.cars;

                    if (cars.isEmpty) {
                      return const SliverFillRemaining(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.search_off,
                                  size: 64, color: Colors.grey),
                              SizedBox(height: 16),
                              Text('No cars found',
                                  style: TextStyle(fontSize: 18)),
                            ],
                          ),
                        ),
                      );
                    }

                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.72,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final car = cars[index];
                            return CarCard(
                              carName: car.name,
                              rating: car.averageRate,
                              location: car.location?.name ?? 'Unknown',
                              price: car.dailyRent?.toInt() ?? 0,
                              imageUrl: car.firstImage,
                              onTap: () {},
                              onBookTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Booking ${car.name}...')),
                                );
                              },
                            );
                          },
                          childCount: cars.length,
                        ),
                      ),
                    );
                  },
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 30)),

                // Our Popular Cars Title
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: CustomTitleAndViewAll(title: "Our Popular Cars"),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 10)),

                // Popular Cars Horizontal List
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 140,
                    child: BlocBuilder<SearchCubit, SearchState>(
                      builder: (context, state) {
                        final cars = state.allCars ?? [];
                        if (cars.isEmpty) return const SizedBox.shrink();

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          itemCount: cars.length > 10 ? 10 : cars.length,
                          itemBuilder: (context, index) {
                            final car = cars[index];
                            return PopularCarCard(
                              carName: car.name,
                              rating: car.averageRate,
                              price: car.dailyRent?.toInt() ?? 0,
                              imageUrl: car.firstImage,
                              onTap: () {},
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 30)),
              ],
            ),
          );
        },
      ),
    );
  }
}

class PopularCarCard extends StatelessWidget {
  final String carName;
  final double rating;
  final int price;
  final String imageUrl;
  final VoidCallback? onTap;

  const PopularCarCard({
    super.key,
    required this.carName,
    required this.rating,
    required this.price,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 240,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.directions_car,
                    size: 40,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    carName,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        rating.toStringAsFixed(1),
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$$price/Day',
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
