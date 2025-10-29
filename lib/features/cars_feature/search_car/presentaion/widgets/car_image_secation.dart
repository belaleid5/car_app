import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:flutter/material.dart';

class CarImageSection extends StatefulWidget {
  final String imageUrl;
  final Function()? onFavoriteTap;
  final ResponsiveHelper res;

  const CarImageSection({
    required this.res,
    super.key,
    required this.imageUrl,
    this.onFavoriteTap,
  });

  @override
  State<CarImageSection> createState() => _CarImageSectionState();
}

class _CarImageSectionState extends State<CarImageSection> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: Container(
            height: widget.res.heightPercent(13),
            color: Colors.grey[300],
            child: Center(
              child: Icon(
                Icons.directions_car,
                size: 80,
                color: Colors.grey[600],
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 8,
          child: GestureDetector(
            onTap: () {
              setState(() => isFavorite = !isFavorite);
              widget.onFavoriteTap?.call();
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}