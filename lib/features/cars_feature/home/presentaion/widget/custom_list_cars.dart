import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/routing/app_router.dart';
import 'package:car_app/core/shared/car_entity.dart';
import 'package:car_app/features/cars_feature/home/presentaion/widget/custom_best_cars.dart';
import 'package:flutter/material.dart';

class CustomListCars extends StatelessWidget {
  const CustomListCars({
    super.key,
    required this.cars,
        this.isLoading = false,
              this.favorite = false,

  });

  final List<CarEntity> cars;
  final bool isLoading;
  final bool favorite;
  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return SizedBox(
      height: res.screenHeight * 0.35,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cars.length,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemBuilder: (context, index) {
          final car = cars[index];

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SizedBox(
              width: res.screenWidth * 0.42,
              child: CardBestCar(
                isLoading: isLoading,
                
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRouter.carDetilesHomeRoute,
                    arguments: {
                      'carId': car.id,
                      'imageUrl': car.mainImageUrl,
                    },
                  );
                }, car:cars[index],
              ),
            ),
          );
        },
      ),
    );
  }
}


