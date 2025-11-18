import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/shared/car_entity.dart';
import 'package:car_app/core/shared/review_entity.dart';
import 'package:car_app/features/cars_feature/car_details/domain/entites/review_details_entity.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/manger/dateils_cubit.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/manger/deatils_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ============================================
// CAR DETAILS PAGE - Main Page
// ============================================

class CarDetailsPage extends StatefulWidget {
  final int carId;

  const CarDetailsPage({
    super.key,
    required this.carId,
  });

  @override
  State<CarDetailsPage> createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  int _currentImageIndex = 0;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    context.read<DetailsCubit>().loadCarDetails(widget.carId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {
          // Loading State
          if (state.status == AppStatus.loading && state.selectedCar == null) {
            return _buildLoadingState();
          }

          // Error State
          if (state.status == AppStatus.failure && state.selectedCar == null) {
            return _buildErrorState(state.errorMessage ?? 'حدث خطأ');
          }

          // No Data State
          if (state.selectedCar == null) {
            return const Center(child: Text('لا توجد بيانات'));
          }

          // Success State
          return _buildSuccessState(state);
        },
      ),
      bottomSheet: BookingBottomSheet(onBookNow: () => _handleBooking(context)),
    );
  }

  // ============================================
  // BUILD METHODS
  // ============================================

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<DetailsCubit>().loadCarDetails(widget.carId);
              },
              child: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessState(DetailsState state) {
    final car = state.selectedCar!;

    return SafeArea(
      child: Column(
        children: [
          CarDetailsAppBar(onBackPressed: () => Navigator.pop(context)),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () =>
                  context.read<DetailsCubit>().refreshReviews(widget.carId),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCarImages(car),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCarHeader(car, state),
                          const SizedBox(height: 24),
                          _buildOwnerSection(car),
                          const SizedBox(height: 24),
                          _buildSpecifications(car),
                          const SizedBox(height: 24),
                          _buildReviewsSection(state),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================
  // SECTION BUILDERS
  // ============================================

  Widget _buildCarImages(CarEntity car) {
    return CarImageCarousel(
      images: car.images.map((img) => img.image).toList(),
      currentIndex: _currentImageIndex,
      isFavorite: _isFavorite,
      onPageChanged: (index) => setState(() => _currentImageIndex = index),
      onFavoriteToggle: () => setState(() => _isFavorite = !_isFavorite),
    );
  }

  Widget _buildCarHeader(CarEntity car, DetailsState state) {
    return CarHeaderSection(
      name: car.name,
      description: car.description,
      rating: _calculateAverageRating(state),
      reviewCount: state.meta?.total ?? 0,
    );
  }

  Widget _buildOwnerSection(CarEntity car) {
    return CarOwnerSection(
      ownerName: car.name,
      ownerImage: car.mainImageUrl,
    );
  }

  Widget _buildSpecifications(CarEntity car) {
    return CarSpecificationsSection(
      specifications: _buildSpecificationsMap(car),
    );
  }

  Widget _buildReviewsSection(DetailsState state) {
    final totalReviews = state.meta?.total ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Review ($totalReviews)',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (totalReviews > 1)
              TextButton(
                onPressed: () => _navigateToAllReviews(context),
                child: const Text(
                  'See All',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        _buildReviewContent(state, totalReviews),
      ],
    );
  }

  Widget _buildReviewContent(DetailsState state, int totalReviews) {
    // Loading reviews
    if (state.status == AppStatus.loading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Has reviews
    if (state.allReviews != null && state.allReviews!.isNotEmpty) {
      return ReviewCard(review: state.allReviews!.first);
    }

    // Empty state
    if (state.status == AppStatus.empty || totalReviews == 0) {
      return _buildEmptyReviewsState();
    }

    return const SizedBox.shrink();
  }

  Widget _buildEmptyReviewsState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(Icons.rate_review_outlined,
                size: 48, color: Colors.grey[400]),
            const SizedBox(height: 8),
            Text(
              'لا توجد مراجعات بعد',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================
  // HELPER METHODS
  // ============================================

  /// Build specifications map from CarEntity
  Map<String, dynamic> _buildSpecificationsMap(CarEntity car) {
    final specs = <String, dynamic>{};

    // Seating Capacity
    if (car.seatingCapacity != null) {
      specs['Capacity'] = '${car.seatingCapacity} Seats';
    }

    // Car Features
    for (var feature in car.carFeatures) {
      specs[feature.name] = feature.name;
    }

    // Basic Info
    specs['Car Type'] = car.carType;
    specs['Brand'] = car.brand.name;
    specs['Color'] = car.color.name;

    // Rent Info
    if (car.dailyRent != null) {
      specs['Daily Rent'] = '\$${car.dailyRent!.toStringAsFixed(0)}';
    }
    if (car.weeklyRent != null) {
      specs['Weekly Rent'] = '\$${car.weeklyRent!.toStringAsFixed(0)}';
    }
    if (car.monthlyRent != null) {
      specs['Monthly Rent'] = '\$${car.monthlyRent!.toStringAsFixed(0)}';
    }

    // Price Info
    if (car.price != null) {
      specs['Price'] = '\$${car.price!.toStringAsFixed(0)}';
    }

    return specs;
  }

  /// Calculate average rating from all reviews
  double _calculateAverageRating(DetailsState state) {
    if (state.allReviews == null || state.allReviews!.isEmpty) {
      return 0.0;
    }

    final totalRating = state.allReviews!.fold<int>(
      0,
      (sum, review) => sum + review.rate,
    );

    return totalRating / state.allReviews!.length;
  }

  /// Navigate to all reviews page
  void _navigateToAllReviews(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<DetailsCubit>(),
          child: AllReviewsPage(carId: widget.carId),
        ),
      ),
    );
  }

  /// Handle booking action
  void _handleBooking(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigating to booking...')),
    );
  }
}

// ============================================
// ALL REVIEWS PAGE
// ============================================

class AllReviewsPage extends StatefulWidget {
  final int carId;

  const AllReviewsPage({super.key, required this.carId});

  @override
  State<AllReviewsPage> createState() => _AllReviewsPageState();
}

class _AllReviewsPageState extends State<AllReviewsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<DetailsCubit>().loadMoreReviews();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('All Reviews'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {
          // Loading State
          if (state.status == AppStatus.loading && state.allReviews == null) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error State
          if (state.status == AppStatus.failure && state.allReviews == null) {
            return _buildErrorState(context, state.errorMessage ?? 'حدث خطأ');
          }

          // Empty State
          if (state.allReviews == null || state.allReviews!.isEmpty) {
            return _buildEmptyState();
          }

          // Success State
          return _buildReviewsList(state);
        },
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<DetailsCubit>().loadCarDetails(widget.carId);
              },
              child: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.rate_review_outlined,
              size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'لا توجد مراجعات',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsList(DetailsState state) {
    return RefreshIndicator(
      onRefresh: () =>
          context.read<DetailsCubit>().refreshReviews(widget.carId),
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(20),
        itemCount: state.allReviews!.length + (state.hasReachedMax ? 0 : 1),
        itemBuilder: (context, index) {
          // Show loading indicator at the end
          if (index >= state.allReviews!.length) {
            return const Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: FullWidthReviewCard(review: state.allReviews![index]),
          );
        },
      ),
    );
  }
}

// ============================================
// REUSABLE WIDGETS
// ============================================

class CarDetailsAppBar extends StatelessWidget {
  final VoidCallback onBackPressed;

  const CarDetailsAppBar({super.key, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleIconButton(icon: Icons.arrow_back, onTap: onBackPressed),
          const Text('Car Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          CircleIconButton(icon: Icons.more_horiz, onTap: () {}),
        ],
      ),
    );
  }
}

class CarImageCarousel extends StatelessWidget {
  final List<String> images;
  final int currentIndex;
  final bool isFavorite;
  final Function(int) onPageChanged;
  final VoidCallback onFavoriteToggle;

  const CarImageCarousel({
    super.key,
    required this.images,
    required this.currentIndex,
    required this.isFavorite,
    required this.onPageChanged,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return _buildEmptyImagePlaceholder();
    }

    return SizedBox(
      height: 280,
      child: Stack(
        children: [
          _buildImageCarousel(),
          _buildFavoriteButton(),
          if (images.length > 1) _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildEmptyImagePlaceholder() {
    return SizedBox(
      height: 280,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
          child: Icon(Icons.directions_car, size: 80, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildImageCarousel() {
    return PageView.builder(
      itemCount: images.length,
      onPageChanged: onPageChanged,
      itemBuilder: (_, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            images[index],
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: Colors.grey[200],
              child: const Icon(Icons.directions_car, size: 80),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return Positioned(
      top: 16,
      right: 36,
      child: FavoriteButton(isFavorite: isFavorite, onTap: onFavoriteToggle),
    );
  }

  Widget _buildPageIndicator() {
    return Positioned(
      bottom: 16,
      left: 0,
      right: 0,
      child: PageIndicator(total: images.length, current: currentIndex),
    );
  }
}

class CarHeaderSection extends StatelessWidget {
  final String name;
  final String description;
  final double rating;
  final int reviewCount;

  const CarHeaderSection({
    super.key,
    required this.name,
    required this.description,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            if (reviewCount > 0)
              RatingBadge(rating: rating, reviewCount: reviewCount),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.5),
        ),
      ],
    );
  }
}

class CarOwnerSection extends StatelessWidget {
  final String ownerName;
  final String ownerImage;

  const CarOwnerSection({
    super.key,
    required this.ownerName,
    required this.ownerImage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(ownerImage),
          backgroundColor: Colors.grey[200],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Row(
            children: [
              Text(ownerName,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(width: 4),
              const Icon(Icons.verified, color: Colors.blue, size: 20),
            ],
          ),
        ),
        CircleIconButton(icon: Icons.phone, onTap: () {}),
        const SizedBox(width: 8),
        CircleIconButton(icon: Icons.chat_bubble_outline, onTap: () {}),
      ],
    );
  }
}

class CarSpecificationsSection extends StatelessWidget {
  final Map<String, dynamic> specifications;

  const CarSpecificationsSection({super.key, required this.specifications});

  @override
  Widget build(BuildContext context) {
    final specs = specifications.entries.toList();
    if (specs.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Car features',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.95,
          ),
          itemCount: specs.length,
          itemBuilder: (_, index) => SpecificationCard(
            specKey: specs[index].key,
            specValue: specs[index].value.toString(),
          ),
        ),
      ],
    );
  }
}

// ============================================
// SMALL REUSABLE COMPONENTS
// ============================================

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const CircleIconButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Icon(icon, size: 20, color: Colors.grey[800]),
      ),
    );
  }
}

class FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onTap;

  const FavoriteButton(
      {super.key, required this.isFavorite, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: Colors.white, shape: BoxShape.circle),
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.red : Colors.grey[700],
          size: 24,
        ),
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  final int total;
  final int current;

  const PageIndicator({super.key, required this.total, required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: current == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: current == index ? Colors.black : Colors.grey[400],
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}

class RatingBadge extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const RatingBadge(
      {super.key, required this.rating, required this.reviewCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Text(rating.toStringAsFixed(1),
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(width: 4),
            const Icon(Icons.star, color: Colors.orange, size: 20),
          ],
        ),
        Text('($reviewCount Reviews)',
            style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}

class SpecificationCard extends StatelessWidget {
  final String specKey;
  final String specValue;

  const SpecificationCard({
    super.key,
    required this.specKey,
    required this.specValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(_getIcon(specKey), size: 28, color: Colors.grey[700]),
          const SizedBox(height: 8),
          Text(specKey,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          Text(specValue,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  IconData _getIcon(String key) {
    final lowerKey = key.toLowerCase();
    if (lowerKey.contains('seat') || lowerKey.contains('capacity'))
      return Icons.event_seat;
    if (lowerKey.contains('engine') || lowerKey.contains('hp'))
      return Icons.settings;
    if (lowerKey.contains('speed')) return Icons.speed;
    if (lowerKey.contains('auto') || lowerKey.contains('pilot'))
      return Icons.radio_button_checked;
    if (lowerKey.contains('charge') || lowerKey.contains('battery'))
      return Icons.battery_charging_full;
    if (lowerKey.contains('park')) return Icons.local_parking;
    if (lowerKey.contains('price') || lowerKey.contains('rent'))
      return Icons.attach_money;
    if (lowerKey.contains('brand')) return Icons.directions_car;
    if (lowerKey.contains('color')) return Icons.palette;
    if (lowerKey.contains('type')) return Icons.category;
    return Icons.info_outline;
  }
}

class ReviewCard extends StatelessWidget {
  final ReviewDetailsEntity review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(review.userImage),
                backgroundColor: Colors.grey[200],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review.username,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                    Row(
                      children: [
                        Text(review.rate.toString(),
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600)),
                        const SizedBox(width: 4),
                        const Icon(Icons.star, color: Colors.orange, size: 14),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review.review,
            style: TextStyle(
                fontSize: 13, color: Colors.grey[600], height: 1.4),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class FullWidthReviewCard extends StatelessWidget {
  final ReviewDetailsEntity review;

  const FullWidthReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(review.userImage),
                backgroundColor: Colors.grey[200],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review.username,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    Row(
                      children: [
                        Text(review.rate.toString(),
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600)),
                        const SizedBox(width: 4),
                        const Icon(Icons.star, color: Colors.orange, size: 16),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review.review,
            style:
                TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.5),
          ),
        ],
      ),
    );
  }
}

class BookingBottomSheet extends StatelessWidget {
  final VoidCallback onBookNow;

  const BookingBottomSheet({super.key, required this.onBookNow});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5))
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: onBookNow,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2C3E50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Book Now',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, color: Colors.white, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}