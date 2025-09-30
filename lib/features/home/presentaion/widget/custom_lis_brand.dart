
import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/features/home/presentaion/manger/hoem_state.dart';
import 'package:car_app/features/home/presentaion/manger/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomListBrand extends StatelessWidget {
  const CustomListBrand({
    super.key,
    required this.res,
  });

  final ResponsiveHelper res;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        // Loading state
        if (state.status == AppStatus.loading) {
          return _buildShimmerLoading(res);
        }

        // Error state
        if (state.status == AppStatus.failure) {
          return _buildErrorWidget(context, state.errorMessage);
        }

        // Empty state
        if (state.brands.isEmpty) {
          return _buildEmptyWidget();
        }

        // Success state
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: SizedBox(
            height: res.screenHeight * 0.125,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.brands.length,
              itemBuilder: (context, index) {
                final brand = state!.brands[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to brand details
                      // Navigator.push(...)
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.neutral100,
                          radius: 40,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: brand.image,
                              fit: BoxFit.cover,
                              width: 60,
                              height: 60,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: 80,
                          child: Text(
                            brand.name,
                            style: AppTextStyles.labelSmall(),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  // Shimmer Loading Widget
  Widget _buildShimmerLoading(ResponsiveHelper res) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: res.screenHeight * 0.125,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: 60,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Error Widget
  Widget _buildErrorWidget(BuildContext context, String? errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            errorMessage ?? 'حدث خطأ في تحميل البراندات',
            style: AppTextStyles.labelSmall(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.read<HomeCubit>().refreshBrands(),
            child: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }

  // Empty State Widget
  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.inbox, size: 48, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            'لا توجد براندات متاحة',
            style: AppTextStyles.labelSmall(),
          ),
        ],
      ),
    );
  }
}

// ====================
// Alternative: Skeleton Loading (without package)
// ====================
class BrandSkeletonLoader extends StatelessWidget {
  const BrandSkeletonLoader({super.key, required this.res});

  final ResponsiveHelper res;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: res.screenHeight * 0.125,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 60,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ====================
// Usage in Home Page
// ====================
/*
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<BrandCubit>()..fetchBrands(),
        child: CustomListBrand(res: res),
      ),
    );
  }
}
*/