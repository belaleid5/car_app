import 'package:car_app/core/extention/adaptive_input_field.dart';
import 'package:car_app/core/functions/app_validators.dart';
import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/widget/cutsom_eleveted_button.dart';
import 'package:car_app/features/auth/presentation/widgets/custom_passsword_text_form.dart';
import 'package:car_app/features/auth/presentation/widgets/custom_remember_and_fogetpasssowrd.dart';
import 'package:flutter/material.dart';

class AuthSection extends StatefulWidget {
  const AuthSection({super.key});

  @override
  State<AuthSection> createState() => _AuthSectionState();
}

class _AuthSectionState extends State<AuthSection> {
  final TextEditingController _emailPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return Column(
      spacing: 18,
      children: [
        AdaptiveInputField(
          controller: _emailPhoneController,
          context: context,
          hintText: 'Email/Phone Number',
          validate: AppValidator.validateEmail,
        ),
        CustomPasswordFormField(passwordController: _passwordController),
        CustomRememberAndForgetPassword(),
        CustomElevatedButton(
          res: res,
          titleColor: AppColors.neutral100,
          buttonColor: AppColors.neutral900,
          title: 'Login',
        ),
        CustomElevatedButton(
          res: res,
          titleColor: AppColors.black,
          buttonColor: AppColors.neutral100,
          title: 'Sign Up',
        ),
      ],
    );
  }
}
