import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/widget/cutsom_eleveted_button.dart';
import 'package:car_app/features/auth/presentation/widgets/custom_form_verifcation.dart';
import 'package:car_app/features/auth/presentation/widgets/custom_logo_car_and_qent.dart';
import 'package:car_app/features/auth/presentation/widgets/custom_title_verify_section.dart';
import 'package:car_app/features/auth/presentation/widgets/dont_have_an_account.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: res.screenWidth * 0.05),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: CustomLogoCarAndQent(res: res)),
            SliverToBoxAdapter(
              child: SizedBox(height: res.screenHeight * 0.25),
            ),
            SliverToBoxAdapter(
              child: CustomTitleSectionVerify(
                title: "Enter verification code",
                subTitle: "We have send a Code to : +100******00",
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: res.screenHeight * 0.05),
            ),
            SliverToBoxAdapter(child: CustomFormVerification()),
            SliverToBoxAdapter(child: const SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: CustomElevatedButton(
                res: res,
                titleColor: AppColors.white,
                buttonColor: AppColors.neutral900,
                title: 'Continue',
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 20)),
            SliverToBoxAdapter(child: DontHaveOrHaveAccount(onTap: () {},title: "Didn’t receive the OTP?",titleButton: "Resend.",),),
          ],
        ),
      ),
    );
  }
}


