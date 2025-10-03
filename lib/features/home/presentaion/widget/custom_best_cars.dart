import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/widget/cusom_scircular_image_svg.dart';
import 'package:car_app/features/home/presentaion/widget/custom_cached_image_home_screen.dart';
import 'package:flutter/material.dart';

class CustomCardBestCars extends StatelessWidget {
  final String carImage;
  final String carName;
  final double rating;
  final String location;
  final String seats;
  final String pricePerDay;
  final String heartIconPath;
  final String locationIconPath;
  final String seatIconPath;
  final String dollarIconPath;
  final VoidCallback onTap;

  const CustomCardBestCars({
    super.key,
    required this.carImage,
    required this.carName,
    required this.rating,
    required this.location,
    required this.seats,
    required this.pricePerDay,
    required this.heartIconPath,
    required this.locationIconPath,
    required this.seatIconPath,
    required this.dollarIconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: res.screenHeight * 0.50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: res.screenHeight * 0.20,
              child: Stack(
                children: [
                  CachedImageCarsHomeScreen(carImage: carImage, res: res),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: CustomCircleImage(
                      imagePath: heartIconPath,
                      radius: 16,
                      height: 15,
                    ),
                  ),
                ],
              ),
            ),

            // Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      carName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          rating.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 12, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            location,
                            style: const TextStyle(
                                fontSize: 10, color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          pricePerDay,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        const Icon(Icons.event_seat,
                            size: 12, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          seats,
                          style:
                              const TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

