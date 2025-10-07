import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/functions/loading_function.dart';
import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/routing/app_router.dart';
import 'package:car_app/core/services/server_locator.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/core/widget/custom_toast.dart';
import 'package:car_app/core/widget/cutsom_eleveted_button.dart';
import 'package:car_app/features/auth_feature/domain/entities/confirm_code_phone_entity.dart';
import 'package:car_app/features/auth_feature/presentation/blocs/auth_cubit.dart';
import 'package:car_app/features/auth_feature/presentation/blocs/auth_states.dart';
import 'package:car_app/features/auth_feature/presentation/widgets/custom_form_verifcation.dart';
import 'package:car_app/core/widget/custom_logo_car_and_qent.dart';
import 'package:car_app/features/auth_feature/presentation/widgets/custom_title_verify_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpVerifyCodePhoneScreen extends StatefulWidget {
  const OtpVerifyCodePhoneScreen({super.key});

  @override
  State<OtpVerifyCodePhoneScreen> createState() =>
      _OtpVerifyCodePhoneScreenState();
}

class _OtpVerifyCodePhoneScreenState extends State<OtpVerifyCodePhoneScreen> {
  final TextEditingController _codeController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();
  String? verifyToken;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    verifyToken ??= ModalRoute.of(context)?.settings.arguments as String?;
  }

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    
    return BlocProvider<AuthCubit>(
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
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: AppColors.white,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: res.screenWidth * 0.05),
              child: Form(
                key: _key,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(height: res.screenHeight * 0.06),
                    ),
                    SliverToBoxAdapter(child: CustomLogoCarAndQent(res: res)),
                    SliverToBoxAdapter(
                      child: SizedBox(height: res.screenHeight * 0.15),
                    ),
                    SliverToBoxAdapter(
                      child: CustomTitleSectionVerify(
                        title: "Enter verification code",
                        subTitle: "We have sent a Code to : your Phone Number",
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: res.screenHeight * 0.05),
                    ),
                    SliverToBoxAdapter(
                      child: CustomFormVerification(controller: _codeController),
                    ),
                    SliverToBoxAdapter(child: const SizedBox(height: 20)),
                    SliverToBoxAdapter(
                      child: CustomElevatedButton(
                        res: res,
                        titleColor: AppColors.white,
                        buttonColor: AppColors.neutral900,
                        title: state.status == AppStatus.loading
                            ? loadingWidget()
                            : Text(
                                "Confirm",
                                style: AppTextStyles.bodyLarge().copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            if (verifyToken == null || verifyToken!.isEmpty) {
                              CustomToast.show(context, "Verify token not found!");
                              return;
                            }

                            final request = ConfirmCodePhoneEntity(
                              verifyToken: verifyToken!,
                              verifyCode: _codeController.text.trim(),
                            );

                            context.read<AuthCubit>().confirmCodePhone(request);
                          }
                        },
                      ),
                    ),
                    SliverToBoxAdapter(child: const SizedBox(height: 20)),
                    SliverToBoxAdapter(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRouter.loginRoute,
                          );
                        },
                        child: Text(
                          "Skip",
                          style: AppTextStyles.h5().copyWith(
                            color: AppColors.neutral900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }
}