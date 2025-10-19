import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_images.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/manger/car_details_cubit.dart' show ReviewsCubit;
import 'package:car_app/features/cars_feature/car_details/presentaion/manger/car_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CustomUserData extends StatelessWidget {
  const CustomUserData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsCubit, ReviewsState>(
      builder: (context, state) {
        // Failure state
        if (state.status == AppStatus.failure) {
          return Center(
            child: Text(
              state.errorMessage ?? 'Failed to load user data',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (state.status == AppStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        final username = state.reviews?.username ?? 'John Doe';
        final userImage = state.reviews?.user_image ?? '';

        return Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: (userImage.isNotEmpty)
                  ? NetworkImage(userImage)
                  : const AssetImage(AppImages.persion_image) as ImageProvider,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                username,
                style: AppTextStyles.bodyMedium(color: AppColors.black),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(
              AppImages.blueMarkIcon,
              width: 16,
              height: 16,
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                AppImages.callIcon,
                width: 36,
                height: 36,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                AppImages.messageIcon,
                width: 36,
                height: 36,
              ),
            ),
          ],
        );
      },
    );
  }
}