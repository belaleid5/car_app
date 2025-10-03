import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_images.dart';
import 'package:car_app/features/home/presentaion/widget/custom_best_cars.dart';
import 'package:flutter/material.dart';

class CustomListCars extends StatelessWidget {
  const CustomListCars({super.key, required this.cars});

final List cars;
  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return SizedBox(
      height: res.hp(38),
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
              child: CustomCardBestCars(
                carImage: car.mainImageUrl,
                carName: car.name,
                rating: car.averageRate,
                location: car.location?.name ?? 'Unknown',
                seats: car.seatingCapacity?.toString() ?? '4',
                pricePerDay: _formatPrice(car),
                heartIconPath: AppImages.heartIcon,
                locationIconPath: AppImages.assetsIconsMapIcon,
                seatIconPath: AppImages.assetsIconsSeatIcon,
                dollarIconPath: AppImages.assetsIconsDollerIcon,
                onTap: () {
                  debugPrint('Tapped: ${car.name}');
                },
              ),
            ),
          );
        },
      ),
    );
  }
}









String _formatPrice(dynamic car) {
    if (car.isForRent && car.dailyRent != null) {
      return '\$${car.dailyRent!.toStringAsFixed(0)}/day';
    }
    if (car.isForPay && car.price != null) {
      return '\$${car.price!.toStringAsFixed(0)}';
    }
    return 'Contact';
  }
