import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/features/auth/presentation/widgets/custom_title_verify_section.dart';
import 'package:car_app/features/auth/presentation/widgets/custom_verify_sction.dart';
import 'package:flutter/material.dart';

class VerifyPhoneScreen extends StatelessWidget {
  const VerifyPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: res.screenWidth * 0.05),
        child: Align(
          alignment: Alignment.center,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(height: res.screenHeight * 0.3),
              ),
              SliverToBoxAdapter(child: CustomTitleSectionVerifyPhone()),
              SliverToBoxAdapter(child: CustomVerifySection()),
            ],
          ),
        ),
      ),
    );
  }
}
