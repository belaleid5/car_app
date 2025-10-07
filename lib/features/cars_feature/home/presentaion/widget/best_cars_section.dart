import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/features/cars_feature/home/presentaion/manger/home_cubit.dart';
import 'package:car_app/features/cars_feature/home/presentaion/manger/home_state.dart';
import 'package:car_app/features/cars_feature/home/presentaion/widget/custom_list_cars.dart';
import 'package:car_app/features/cars_feature/home/presentaion/widget/custom_title_and_view_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BestCarsSection extends StatefulWidget {
  const BestCarsSection({super.key,});
  
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
                final isLoading = state.status == AppStatus.loading;
                final cars = isLoading ? _getDummyCars() : state.bestCars;

                return Skeletonizer(
                  enabled: isLoading,
                  child: CustomListCars(cars: cars),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

 List _getDummyCars() {
  return List.generate(3, (index) => _DummyCar(
    id: index + 1,  // ضيف id هنا
    mainImageUrl: 'https://via.placeholder.com/300',
    name: 'Car Name Loading',
    averageRate: 5.0,
    location: _DummyLocation(name: 'Location'),
    seatingCapacity: 4,
    isForRent: true,
    dailyRent: 100.0,
    isForPay: false,
    price: null,
  ));
}
}



class _DummyLocation {
  final String name;
  _DummyLocation({required this.name});
}

class _DummyCar {
  final int? id; // ضيف الـ id
  final String mainImageUrl;
  final String name;
  final double averageRate;
  final _DummyLocation? location;
  final int seatingCapacity;
  final bool isForRent;
  final double? dailyRent;
  final bool isForPay;
  final double? price;

  _DummyCar({
    this.id, // ضيف هنا
    required this.mainImageUrl,
    required this.name,
    required this.averageRate,
    required this.location,
    required this.seatingCapacity,
    required this.isForRent,
    required this.dailyRent,
    required this.isForPay,
    required this.price,
  });
}

