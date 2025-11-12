import 'package:car_app/features/cars_feature/home/domain/entity/car_entity.dart';
import 'package:flutter/material.dart';

// Main Card Widget - Single Responsibility
class CardBestCar extends StatelessWidget {
  final CarEntity car;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;
  final bool isFavorite;
  final bool isLoading;

  const CardBestCar({
    super.key,
    required this.car,
    this.onTap,
    this.onFavoriteToggle,
    this.isFavorite = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        decoration: _buildCardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CarImageSection(
              imageUrl: car.mainImageUrl,
              isFavorite: isFavorite,
              onFavoriteToggle: onFavoriteToggle,
              isLoading: isLoading,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CarTitle(name: car.name),
                  const SizedBox(height: 8),
                  _CarRating(
                    rating: car.averageRate,
                    isLoading: isLoading,
                  ),
                  const SizedBox(height: 8),
                  _CarLocation(location: car.locationName),
                  const SizedBox(height: 8),
                  _CarFooter(
                    seats: car.seatsDisplay,
                    pricePerDay: car.dailyRent ?? car.price ?? 0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildCardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}

// Image Section - Single Responsibility
class _CarImageSection extends StatelessWidget {
  final String imageUrl;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;
  final bool isLoading;

  const _CarImageSection({
    required this.imageUrl,
    required this.isFavorite,
    this.onFavoriteToggle,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildCarImage(),
        _buildFavoriteButton(),
      ],
    );
  }

  Widget _buildCarImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Container(
        height: 140,
        width: double.infinity,
        color: Colors.grey[100],
        child: Image.network(
          imageUrl,
          fit: BoxFit.fill,
          errorBuilder: (_, __, ___) => const Icon(
            Icons.directions_car,
            size: 90,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return Positioned(
      top: 8,
      right: 8,
      child: GestureDetector(
        onTap: onFavoriteToggle,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
              ),
            ],
          ),
          child: Icon(
            isLoading
                ? Icons.favorite
                : (isFavorite ? Icons.favorite : Icons.favorite_border),
            color: isLoading
                ? Colors.red
                : (isFavorite ? Colors.red : Colors.grey[600]),
            size: 20,
          ),
        ),
      ),
    );
  }
}

// Title Widget
class _CarTitle extends StatelessWidget {
  final String name;

  const _CarTitle({required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

// Rating Widget
class _CarRating extends StatelessWidget {
  final double rating;
  final bool isLoading;

  const _CarRating({
    required this.rating,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Row(
        children: [
          Container(
            width: 30,
            height: 14,
            decoration: BoxDecoration(
              color: Colors.orange[200],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.star,
            size: 16,
            color: Colors.orange,
          ),
        ],
      );
    }

    return Row(
      children: [
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(width: 4),
        const Icon(
          Icons.star,
          size: 16,
          color: Colors.orange,
        ),
      ],
    );
  }
}

// Location Widget
class _CarLocation extends StatelessWidget {
  final String location;

  const _CarLocation({required this.location});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          size: 16,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            location,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// Footer Widget
class _CarFooter extends StatelessWidget {
  final String seats;
  final double pricePerDay;

  const _CarFooter({
    required this.seats,
    required this.pricePerDay,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSeatsInfo(),
        _buildPriceInfo(),
      ],
    );
  }

  Widget _buildSeatsInfo() {
    return Row(
      children: [
        Icon(
          Icons.event_seat_outlined,
          size: 16,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 4),
        Text(
          '$seats Seats',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceInfo() {
    return Row(
      children: [
        Icon(
          Icons.attach_money,
          size: 16,
          color: Colors.grey[800],
        ),
        Text(
          '${pricePerDay.toStringAsFixed(0)}/Day',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }
}
