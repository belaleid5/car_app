import 'package:car_app/features/cars_feature/search_car/presentaion/manger/search_cubit.dart';
import 'package:car_app/features/cars_feature/search_car/presentaion/widgets/car_card.dart';
import 'package:car_app/features/cars_feature/search_car/presentaion/widgets/empty_widget.dart';
import 'package:car_app/features/cars_feature/search_car/presentaion/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecommendationSection extends StatelessWidget {
  const RecommendationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const SliverFillRemaining(
            child: Center( 
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 2,
              ),
            ),
          );
        }

        if (state.isFailure) {
          return SliverFillRemaining(
            child: CustomErrorWidget(
              message: state.message ?? 'Failed to load cars',
              onRetry: () => context.read<SearchCubit>().getAllCars(isRefresh: true),
            ),
          );
        }

        final cars = state.cars;

        if (cars.isEmpty) {
          return const SliverFillRemaining(
            child: EmptyWidget(message: 'No cars found'),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.72,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final car = cars[index];
                return CarCard(
                  carName: car.name,
                  rating: car.averageRate,
                  location: car.location?.name ?? 'Unknown',
                  price: car.dailyRent
                      != null ? car.dailyRent!.toInt() : 0,
                  imageUrl: car.firstImage,
                  onTap: () => _navigateToDetails(context, car.id),
                  onBookTap: () => _handleBooking(context, car),
                );
              },
              childCount: cars.length,
            ),
          ),
        );
      },
    );
  }


  void _navigateToDetails(BuildContext context, int carId) {
    // Navigate to car details
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening car details: $carId'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _handleBooking(BuildContext context, car) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Booking ${car.name}...'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
