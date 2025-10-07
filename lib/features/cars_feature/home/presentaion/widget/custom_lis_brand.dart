import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/features/cars_feature/home/presentaion/manger/home_cubit.dart';
import 'package:car_app/features/cars_feature/home/presentaion/manger/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomListBrand extends StatefulWidget {
  const CustomListBrand({
    super.key,
    required this.res,
  });

  final ResponsiveHelper res;

  @override
  State<CustomListBrand> createState() => _CustomListBrandState();
}

class _CustomListBrandState extends State<CustomListBrand> {
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
        if (state.status == AppStatus.loading ||
            state.status == AppStatus.initial) {
          return _buildSkeletonLoading(widget.res);
        }

        if (state.status == AppStatus.failure) {
          return _buildErrorWidget(context, state.errorMessage);
        }

        if (state.status == AppStatus.success && state.brands.isEmpty) {
          return _buildEmptyWidget();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            height: widget.res.screenHeight * 0.15, // زودت الـ height
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: state.brands.length,
              separatorBuilder: (context, index) => SizedBox(width: res.wp(6)),
              itemBuilder: (context, index) {
                final brand = state.brands[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to brand details
                  },
                  child: SizedBox(
                    width: 70, // حددت width للـ Column
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // مهم جداً
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.white.withOpacity(0.8),
                          radius: 35,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: brand.image,
                              fit: BoxFit.fill,
                              width: 50,
                              height: 50,
                              placeholder: (context, url) => _buildSkeletonLoading(res),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          brand.name,
                          style: AppTextStyles.labelSmall(),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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

  /// ✅ استبدال Shimmer بـ Skeletonizer
  Widget _buildSkeletonLoading(ResponsiveHelper res) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: res.screenHeight * 0.125,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Skeletonizer(
              enabled: true,
              child: Column(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                  ),
                  const SizedBox(height: 10),
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

  Widget _buildErrorWidget(BuildContext context, String? errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
      ),
    );
  }
}
