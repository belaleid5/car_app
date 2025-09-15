import 'package:car_app/core/di/server_locator.dart';
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
import 'package:car_app/features/auth/domain/entities/reset_password_request_entity.dart';
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
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.white,
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
                      state.message ?? 'Sent to Code failure!',
                    );
                  } else if (state.status == AppStatus.success) {
                    CustomToast.show(
                      context,
                      state.resetPasswordResponse!.code,
                    );

                    Navigator.pushNamed(context, AppRouter.otpRoute);

                  
                    );

                  Navigator.pushNamed(context, 
                    AppRouter.otpRoute,arguments:
                    state.resetPasswordResponse!.resetToken,);
                  }
                },
                builder: (context, state) {
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: SizedBox(height: res.screenHeight * 0.3),
                      ),
                      SliverToBoxAdapter(
                        child: CustomTitleSectionVerify(
                          title: 'Reset your password',
                          subTitle:
                              'Enter the email address associated with your account and we\'ll send you a link to reset your password.',
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: AdaptiveInputField(
                          controller: _emailPhoneController,
                          context: context,
                          hintText: 'Email',
                          validate: (value) => Validators.validateEmail(value),
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: res.rh(20))),
                      SliverToBoxAdapter(
                        child: CustomElevatedButton(
                          res: res,
                          titleColor: AppColors.white,
                          buttonColor: AppColors.neutral900,
                          title:
                              state.status == AppStatus.loading
                                  ? loadingWidget()
                                  : Text(
                                    "Reset Password",
                                    style: AppTextStyles.bodyLarge().copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                _emailPhoneController.text.isNotEmpty) {
                              final request = ResetPasswordRequestEntity(
                                email: _emailPhoneController.text.trim(),
                              );
                              context.read<AuthCubit>().resetPassword(request);

                              final request = ForgetPasswordRequestEntity(
                                email: _emailPhoneController.text.trim(),
                              );
                              context.read<AuthCubit>().forgetPassword(request);
                               
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
           
