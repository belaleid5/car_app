import 'package:car_app/core/services/server_locator.dart';
import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/functions/loading_function.dart';
import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/routing/app_router.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/core/utils/validators.dart';
import 'package:car_app/core/widget/custom_toast.dart';
import 'package:car_app/core/widget/cutsom_eleveted_button.dart';
import 'package:car_app/features/auth_feature/domain/entities/request_verify_code_entity.dart';
import 'package:car_app/features/auth_feature/domain/entities/reset_password_request_entity.dart';
import 'package:car_app/features/auth_feature/presentation/blocs/auth_cubit.dart';
import 'package:car_app/features/auth_feature/presentation/blocs/auth_states.dart';
import 'package:car_app/features/auth_feature/presentation/widgets/custom_form_verifcation.dart';
import 'package:car_app/features/auth_feature/presentation/widgets/custom_passsword_text_form.dart'
    show CustomPasswordFormField;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionAuthConfirmPasswordAndCode extends StatefulWidget {
  final ResponsiveHelper res;
  final String resetToken;

  const SectionAuthConfirmPasswordAndCode({
    super.key,
    required this.res,
    required this.resetToken,
  });

  @override
  State<SectionAuthConfirmPasswordAndCode> createState() =>
      _SectionAuthConfirmPasswordAndCodeState();
}

class _SectionAuthConfirmPasswordAndCodeState
    extends State<SectionAuthConfirmPasswordAndCode> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _codeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status == AppStatus.success) {
            CustomToast.show(context, "Successfully Confirm Password");
            Navigator.pushReplacementNamed(context, AppRouter.loginRoute);
          }
          if (state.status == AppStatus.failure) {
            CustomToast.show(context, state.message!);
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              spacing: 10,
              children: [
                CustomFormVerification(controller: _codeController),
                const SizedBox(height: 20),

                CustomPasswordFormField(
                  passwordController: _passwordController,
                  validate: (value) => Validators.validatePassword(value),
                ),

                CustomPasswordFormField(
                  passwordController: _confirmPasswordController,
                  validate: (value) => Validators.validateConfirmPassword(
                    value,
                    _passwordController.text.trim(),
                  ),
                ),

                const SizedBox(height: 20),
                CustomElevatedButton(
                  res: widget.res,
                  titleColor: AppColors.white,
                  buttonColor: AppColors.neutral900,
                  title: state.status == AppStatus.loading
                      ? loadingWidget()
                      : Text(
                          "Continue",
                          style: AppTextStyles.bodyLarge().copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // التأكد من أن جميع البيانات عبارة عن strings وليست فارغة
                      final code = _codeController.text.trim();
                      final password = _passwordController.text.trim();
                      final confirmPassword = _confirmPasswordController.text.trim();
                      final resetToken = widget.resetToken.trim();

                      // التحقق من أن الكود غير فارغ
                      if (code.isEmpty) {
                        CustomToast.show(context, "Please enter verification code");
                        return;
                      }

                      // التحقق من أن reset token غير فارغ
                      if (resetToken.isEmpty) {
                        CustomToast.show(context, "Reset token is missing");
                        return;
                      }

                      // طباعة البيانات للتأكد من صحتها (يمكن حذفها في الإنتاج)
                      print('Debug - Reset Token: $resetToken');
                      print('Debug - Code: $code');
                      print('Debug - Password: ${password.isNotEmpty ? "***" : "empty"}');
                      print('Debug - Confirm Password: ${confirmPassword.isNotEmpty ? "***" : "empty"}');

                      final request = ResetRequestPasswordEntity(
                        resetToken: resetToken,
                        code: code,
                        password: password,
                        confirmPassword: confirmPassword,
                      );

                      context.read<AuthCubit>().resetPassword(request);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}