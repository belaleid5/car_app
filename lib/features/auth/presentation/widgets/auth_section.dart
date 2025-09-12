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
import 'package:car_app/features/auth/domain/entities/login_entity.dart';
import 'package:car_app/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:car_app/features/auth/presentation/blocs/auth_states.dart';
import 'package:car_app/features/auth/presentation/widgets/custom_passsword_text_form.dart';
import 'package:car_app/features/auth/presentation/widgets/custom_remember_and_fogetpasssowrd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Import your AuthBloc and AuthState/AuthEvent

class AuthSection extends StatefulWidget {
  const AuthSection({super.key});

  @override
  State<AuthSection> createState() => _AuthSectionState();
}

class _AuthSectionState extends State<AuthSection> {
  final TextEditingController _emailPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return BlocProvider(
      create: (_) => sl<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // Handle state changes like showing SnackBars or navigation
          if (state.status == AppStatus.success) {
            CustomToast.show(context, state.message ?? 'Login successful!');

            Navigator.pushNamed(context, '/home');
          } else if (state.status == AppStatus.failure) {
            CustomToast.show(context, state.message ?? 'Login failed!');
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              spacing: 18,
              children: [
                AdaptiveInputField(
                  controller: _emailPhoneController,
                  context: context,
                  hintText: 'Email/Phone Number',
                  validate: (value) => Validators.validateEmail(value),
                ),
                CustomPasswordFormField(
                  passwordController: _passwordController,
                ),
                CustomRememberAndForgetPassword(),
                CustomElevatedButton(
                  res: res,
                  titleColor: AppColors.neutral100,
                  buttonColor: AppColors.neutral900,
                  title: state.status == AppStatus.loading
                    ? loadingWidget()
                    :Text(
                    "Login",
                    style: AppTextStyles.bodyLarge().copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed:state.status == AppStatus.loading
                    ? null
                    : () {
                    if (_formKey.currentState!.validate()) {
                      final login = LoginRequestEntity(
                        email: _emailPhoneController.text.trim(),
                        password: _passwordController.text.trim(),
                      );
                      context.read<AuthCubit>().login(login);
                    }
                  },
                ),
                CustomElevatedButton(
                  res: res,
                  titleColor: AppColors.black,
                  buttonColor: AppColors.neutral100,
                  title: Text(
                    "SignUp",
                    style: AppTextStyles.bodyLarge().copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouter.signUpRoute);
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
