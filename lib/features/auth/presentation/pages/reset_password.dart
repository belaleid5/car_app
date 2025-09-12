import 'package:car_app/core/extention/adaptive_input_field.dart';
import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/routing/app_router.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/core/utils/validators.dart';
import 'package:car_app/core/widget/cutsom_eleveted_button.dart';
import 'package:car_app/features/auth/presentation/widgets/custom_title_verify_section.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _emailPhoneController = TextEditingController();

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
              SliverToBoxAdapter(
                child: CustomTitleSectionVerify(
                  title: 'Reset your password',
                  subTitle: 'Enter the email address associated with your account and we\'ll send you a link to reset your password.',
                ),
              ),
              SliverToBoxAdapter(child: AdaptiveInputField(
                controller: _emailPhoneController,
                context: context,
                hintText: 'Email',
                validate : (value) => Validators.validateEmail(value),
              ),),
              SliverToBoxAdapter(child: SizedBox(height: res.rh(20))),
              SliverToBoxAdapter(
                child: CustomElevatedButton(
                  res: res,
                  titleColor: AppColors.white,
                  buttonColor: AppColors.neutral900,
                  title: 
                
                  Text(
        "Reset Password",
        style: AppTextStyles.bodyLarge().copyWith(
          color:  Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
                  onPressed: () {
                    if (_emailPhoneController.text.isNotEmpty) {
                      // Handle password reset logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Password reset link sent to ${_emailPhoneController.text}')),
                        
                      );
                      Navigator.pushNamed(context, AppRouter.otpRoute);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
