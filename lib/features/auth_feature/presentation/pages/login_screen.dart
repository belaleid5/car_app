import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_images.dart';
import 'package:car_app/features/auth_feature/presentation/widgets/auth_section.dart';
import 'package:car_app/features/auth_feature/presentation/widgets/custom_button_social.dart';
import 'package:car_app/features/auth_feature/presentation/widgets/custom_divider_and_or.dart';
import 'package:car_app/core/widget/custom_logo_car_and_qent.dart';
import 'package:car_app/features/auth_feature/presentation/widgets/custom_title_auth_section.dart';
import 'package:car_app/features/auth_feature/presentation/widgets/dont_have_an_account.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return Scaffold(
        resizeToAvoidBottomInset: true, // يخلي الصفحة تطلع لفوق تلقائي

      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: res.availableWidth * 0.06),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: res.rh(80))),
            SliverToBoxAdapter(child: CustomLogoCarAndQent(res: res)),
            SliverToBoxAdapter(child: SizedBox(height: res.rh(20))),
            SliverToBoxAdapter(
              child: CustomTitleAuthSection(
                title: 'Welcome Back\nReady to hit the road.',
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: res.rh(20))),
            SliverToBoxAdapter(child: AuthSection()),
            SliverToBoxAdapter(child: SizedBox(height: res.rh(40))),
            SliverToBoxAdapter(child: CustomDividerAndOR(res: res)),
            SliverToBoxAdapter(child: SizedBox(height: res.rh(40))),
            SliverToBoxAdapter(
              child: CustomButtonSocial(
                res: res,
                title: 'Apple',
                imagePath: AppImages.assetsIconsAppleIcon,
                onPressed: () {},
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: res.rh(20))),
            SliverToBoxAdapter(
              child: CustomButtonSocial(
                res: res,
                title: 'Google',
                imagePath: AppImages.assetsIconsGoogleIcon,
                onPressed: () {},
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: res.rh(40))),
            SliverToBoxAdapter(child: DontHaveOrHaveAccount()),
            SliverToBoxAdapter(child: SizedBox(height: res.rh(40))),
          ],
        ),
      ),
    );
  }
}
