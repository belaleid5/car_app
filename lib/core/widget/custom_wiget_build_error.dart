import 'package:car_app/features/cars_feature/home/presentaion/manger/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomWidgetBuildError extends StatelessWidget {
  const CustomWidgetBuildError({super.key, this.error, required this.height});

final String? error;
final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(error ?? 'Failed to load cars'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.read<HomeCubit>().fetchBestCars(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}













