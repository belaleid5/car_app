import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:flutter/material.dart';

class CustomItemSliderSection extends StatelessWidget {
  final String imagePath;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  const CustomItemSliderSection({
    super.key,
    required this.imagePath,
    required this.isFavorite,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            imagePath,
            width: double.infinity,
            height: res.heightPercent(220),
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: Icon(Icons.car_rental, size: 50),
              );
            },
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: InkWell(
            onTap: onFavoriteTap,
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.9),
              radius: 18,
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}