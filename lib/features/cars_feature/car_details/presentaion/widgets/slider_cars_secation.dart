import 'package:car_app/core/extention/main_carousel_slider.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/pages/car_details_screen.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/widgets/custom_item_slider_section.dart';
import 'package:car_app/features/cars_feature/home/data/model/car_image_model.dart';
import 'package:flutter/material.dart';

class SliderCarsSection extends StatefulWidget {
  final dynamic car; 
  final String? fallbackImageUrl;

  const SliderCarsSection({
    super.key,
    required this.car,
    this.fallbackImageUrl,
  });

  @override
  State<SliderCarsSection> createState() => _SliderCarsSectionState();
}

class _SliderCarsSectionState extends State<SliderCarsSection> {
  int _currentIndex = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final images = (widget.car.images as List)
        .map<String>((img) => (img as CarImageModel).image)
        .toList();

    return Column(
      children: [
        MainCarouselSlider(
          options: CarouselOptions(
            height: 230,
            enlargeCenterPage: true,
            autoPlay: true,
            viewportFraction: 0.85,
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
          items: images.map((image) {
            return CustomItemSliderSection(
              imagePath: image,
              isFavorite: false,
              onFavoriteTap: () {},
            );
          }).toList(),
        ),

        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToItem(entry.key),
              child: Container(
                width: 10.0,
                height: 10.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key
                      ? Colors.black
                      : Colors.grey.shade400,
                ),
              ),
            );
          }).toList(),
        ),

      
      ],
    );
  }
}
