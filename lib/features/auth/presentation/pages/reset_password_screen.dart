import 'package:car_app/core/services/server_locator.dart';
import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/extention/adaptive_input_field.dart';
import 'package:car_app/core/functions/loading_function.dart';
import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/routing/app_router.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/core/utils/validators.dart';
import 'package:car_app/core/widget/custom_toast.dart';
import 'package:car_app/core/widget/cutsom_eleveted_button.dart';
import 'package:car_app/features/auth/domain/entities/forget_password_request_entity.dart';
import 'package:car_app/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:car_app/features/auth/presentation/blocs/auth_states.dart';
import 'package:car_app/features/auth/presentation/widgets/custom_title_verify_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _emailPhoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();





  @override
  void dispose() {
    _emailPhoneController.dispose();
    super.dispose();
  }






  void _handleResetPassword(BuildContext context) {
    if (
        _formKey.currentState!.validate() &&
        _emailPhoneController.text.isNotEmpty
        
        ) {
      final request = ForgetPasswordRequestEntity(
                      email: _emailPhoneController.text.trim(),
                          );
      context.read<AuthCubit>().forgetPassword(request);
    }
  }





  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);

    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: Scaffold(
          resizeToAvoidBottomInset: true, // يخلي الصفحة تطلع لفوق تلقائي

        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
              padding: EdgeInsets.symmetric(horizontal: res.screenWidth * 0.05),
          child: Align(
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state.status == AppStatus.failure) {
                    CustomToast.show(
                      context,
                      state.message ?? 'Failed to send reset code!',
                    );
                  } else if (state.status == AppStatus.success) {
                    if (state.message != null && state.message!.isNotEmpty) {
                      CustomToast.show(context, state.confirmPasswordResponse!.code);

                      String? resetToken;

                      if (state.confirmPasswordResponse != null) {
                        resetToken = state.confirmPasswordResponse!.resetToken;
                      }

                      if (resetToken != null && resetToken.isNotEmpty) {
                        Navigator.pushNamed(
                          context,
                          AppRouter.otpRoute,
                          arguments: resetToken,
                        );
                      } else {
                        CustomToast.show(
                          context,
                          state.confirmPasswordResponse!.code,
                        );
                      }
                    } else {
                      CustomToast.show(
                        context,
                        state.confirmPasswordResponse!.code,
                      );
                    }
                  }
                },
                builder: (context, state) {
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: SizedBox(height: res.screenHeight * 0.2),
                      ),
                      SliverToBoxAdapter(
                        child: CustomTitleSectionVerify(
                          title: 'Reset your password',
                          subTitle:
                              'Enter the email address associated with your account and we\'ll send you a reset code.',
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(height: res.screenHeight * 0.05),
                      ),
                      SliverToBoxAdapter(
                        child: AdaptiveInputField(
                          controller: _emailPhoneController,
                          context: context,
                          hintText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          validate: (value) => Validators.validateEmail(value),
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: res.rh(30))),
                      SliverToBoxAdapter(
                        child: CustomElevatedButton(
                          res: res,
                          titleColor: AppColors.white,
                          buttonColor: AppColors.neutral900,
                          title: state.status == AppStatus.loading
                              ? loadingWidget()
                              : Text(
                                  "Send Reset Code",
                                  style: AppTextStyles.bodyLarge().copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                          // استخدام onTap بدلاً من onPressed إذا كان الـ widget يتطلب ذلك
                          onPressed: state.status == AppStatus.loading
                              ? null
                              : () => _handleResetPassword(context),
                          // أو onPressed حسب تعريف الـ CustomElevatedButton
                          // onPressed: state.status == AppStatus.loading
                          //     ? null
                          //     : () => _handleResetPassword(context),
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: res.rh(20))),
                      // زر للرجوع للـ Login (اختياري)
                      SliverToBoxAdapter(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRouter.loginRoute,
                              (route) => false,
                            );
                          },
                          child: Text(
                            'Back to Login',
                            style: AppTextStyles.bodyMedium().copyWith(
                              color: AppColors.neutral900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
