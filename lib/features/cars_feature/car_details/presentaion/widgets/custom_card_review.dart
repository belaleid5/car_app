import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_images.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/manger/dateils_cubit.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/manger/deatils_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CardReview extends StatelessWidget {
  const CardReview({super.key});

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);

    return SizedBox(
      height: res.screenHeight * 0.12,
      child: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {
          // ✅ الحالة: تحميل
          if (state.status == AppStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          // ✅ الحالة: فشل
          if (state.status == AppStatus.failure) {
            return Center(
              child: Text(
                state.errorMessage ?? 'فشل في تحميل المراجعات',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          // ✅ الحالة: لا توجد مراجعات
          if (state.allReviews == null || state.allReviews!.isEmpty) {
            return const Center(child: Text('لا توجد مراجعات حالياً'));
          }

          // ✅ الحالة: مراجعات جاهزة للعرض
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.allReviews!.length,
            itemBuilder: (context, index) {
              final rev = state.allReviews![index];

              return Container(
                width: res.widthPercent(80),
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.neutral900,
                    width: 0.2,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.0,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: (rev.userImage.isNotEmpty)
                              ? NetworkImage(rev.userImage)
                              : const AssetImage(
                                  AppImages.persion_image,
                                ) as ImageProvider,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            rev.username,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.bodySmall(
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Row(
                          children: [
                            Text(
                              "${rev.rate}",
                              style: AppTextStyles.bodyMedium(
                                color: AppColors.black,
                              ),
                            ),
                            const SizedBox(width: 5),
                            SvgPicture.asset(
                              AppImages.starIcon,
                              width: 16,
                              height: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      rev.review,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.caption(
                        color: AppColors.neutral400,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}