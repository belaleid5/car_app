import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/features/cars_feature/search_car/presentaion/widgets/car_image_secation.dart';
import 'package:car_app/features/cars_feature/search_car/presentaion/widgets/car_info_header.dart';
import 'package:car_app/features/cars_feature/search_car/presentaion/widgets/car_rating.dart';
import 'package:car_app/features/cars_feature/search_car/presentaion/widgets/location_widget.dart';
import 'package:car_app/features/cars_feature/search_car/presentaion/widgets/price_button_secation.dart';
import 'package:flutter/material.dart';

class CarRentalCard extends StatelessWidget {
  final String carModel;
  final double rating;
  final String location;
  final int pricePerDay;
  final String imageUrl;
  final Function()? onBookTap;

  const CarRentalCard({
    super.key,
    required this.carModel,
    required this.rating,
    required this.location,
    required this.pricePerDay,
    required this.imageUrl,
    this.onBookTap,
  });

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarImageSection(res: res, imageUrl: imageUrl),
            CarInfoHeader(carName: carModel),
            RatingWidget(rating: rating),
            LocationWidget(location: location),
            PriceAndButtonSection(
              pricePerDay: pricePerDay,
              onBookTap: onBookTap ?? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Booked: $carModel')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
