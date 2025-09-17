import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/core/widget/cutsom_eleveted_button.dart';
import 'package:car_app/features/auth/presentation/widgets/custom_form_verifcation.dart';
import 'package:car_app/features/auth/presentation/widgets/auht_section_otp_and_confirm_password.dart' show SectionAuthConfirmPasswordAndCode;
import 'package:car_app/features/auth/presentation/widgets/custom_logo_car_and_qent.dart';
import 'package:car_app/features/auth/presentation/widgets/custom_title_verify_section.dart';
import 'package:car_app/features/auth/presentation/widgets/dont_have_an_account.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.resetToken});

  final String resetToken;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return Scaffold(
        resizeToAvoidBottomInset: true, // يخلي الصفحة تطلع لفوق تلقائي

      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: res.screenWidth * 0.05),
        child: CustomScrollView(
          slivers: [
           
            SliverToBoxAdapter(child: SizedBox(height: res.screenHeight * 0.06)),
            SliverToBoxAdapter(child: CustomLogoCarAndQent(res: res)),
            SliverToBoxAdapter(child: SizedBox(height: res.screenHeight * 0.15)),
            SliverToBoxAdapter(
              child: CustomTitleSectionVerify(
                title: "Enter verification code",
                subTitle: "We have sent a Code to : +100******00",
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: res.screenHeight * 0.05)),
            SliverToBoxAdapter(
              child: SectionAuthConfirmPasswordAndCode(
                res: res,
                resetToken: widget.resetToken, 
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: DontHaveOrHaveAccount(
                onTap: () {},
                title: "Didn't receive the OTP?",
                titleButton: "Resend.",
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();    
    super.dispose();
  }
}