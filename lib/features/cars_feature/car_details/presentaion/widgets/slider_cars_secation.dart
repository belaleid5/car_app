import 'package:car_app/core/extention/main_carousel_slider.dart';
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
    // ✅ الحل الكامل: معالجة جميع الحالات
    
    // 1️⃣ لو الـ car null، استخدم fallback
    if (widget.car == null) {
      return _buildFallbackImage();
    }

    // 2️⃣ لو images null أو فاضية
    if (widget.car.images == null || (widget.car.images as List).isEmpty) {
      // جرب تستخدم first_image
      if (widget.car.firstImage != null) {
        return _buildSingleImage(widget.car.firstImage);
      }
      // لو مفيش، استخدم fallback
      return _buildFallbackImage();
    }

    // 3️⃣ لو كل حاجة تمام، اعرض الـ slider
    try {
      final images = (widget.car.images as List)
          .map<String>((img) => (img as CarImageModel).image)
          .toList();

      // لو الـ images بعد الـ mapping طلعت فاضية
      if (images.isEmpty) {
        return _buildFallbackImage();
      }

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

          // عرض الـ indicators بس لو في أكتر من صورة
          if (images.length > 1)
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
    } catch (e) {
      // لو حصل أي error في الـ mapping، استخدم fallback
      print('Error in SliderCarsSection: $e');
      return _buildFallbackImage();
    }
  }

  // ✅ Widget لعرض صورة واحدة بس
  Widget _buildSingleImage(String imageUrl) {
    return CustomItemSliderSection(
      imagePath: imageUrl,
      isFavorite: false,
      onFavoriteTap: () {},
    );
  }

  // ✅ Widget لعرض fallback image أو placeholder
  Widget _buildFallbackImage() {
    if (widget.fallbackImageUrl != null) {
      return CustomItemSliderSection(
        imagePath: widget.fallbackImageUrl!,
        isFavorite: false,
        onFavoriteTap: () {},
      );
    }

    // لو مفيش fallback، اعرض placeholder
    return Container(
      height: 230,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.directions_car,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 8),
            Text(
              'No images available',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}