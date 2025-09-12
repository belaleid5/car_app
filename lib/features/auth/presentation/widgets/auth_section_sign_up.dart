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
import 'package:car_app/features/auth/domain/entities/register_request_entity.dart';
import 'package:car_app/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:car_app/features/auth/presentation/blocs/auth_states.dart';
import 'package:car_app/features/auth/presentation/widgets/custom_coountry_phone.dart';
import 'package:car_app/features/auth/presentation/widgets/custom_passsword_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthSectionSignUp extends StatefulWidget {
  const AuthSectionSignUp({super.key});

  @override
  State<AuthSectionSignUp> createState() => _AuthSectionSignUpState();
}

class _AuthSectionSignUpState extends State<AuthSectionSignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  String _fullPhoneNumber = '';
  String _countryCode = '+20';
  String _phoneNumber = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // تحديث القيم بدون setState - فقط حفظ البيانات
  void _onPhoneChanged(String fullPhone, String countryCode, String phoneNumber) {
    // تحديث القيم بدون setState لتحسين الأداء
    _fullPhoneNumber = fullPhone;
    _countryCode = countryCode;
    _phoneNumber = phoneNumber;
    
    // طباعة للتأكد من التحديث (يمكن حذفها في الإنتاج)
    debugPrint("Full phone: $fullPhone");
    debugPrint("Country Code: $countryCode");
    debugPrint("Phone Number: $phoneNumber");
  }

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AppStatus.success) {
          CustomToast.show(context, state.message ?? 'Registration successful!');
          Navigator.pushNamed(context, AppRouter.loginRoute);
        } else if (state.status == AppStatus.failure) {
          CustomToast.show(context, state.message ?? 'Registration failed!');
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            spacing: 18,
            children: [
              // Full Name Field
              AdaptiveInputField(
                controller: _fullNameController,
                context: context,
                hintText: 'Full Name',
                validate: (value) => Validators.validateFullName(value),
              ),

              // Email Field
              AdaptiveInputField(
                controller: _emailController,
                context: context,
                hintText: 'Email',
                validate: (value) => Validators.validateEmail(value),
              ),

              // Password Field
              CustomPasswordFormField(passwordController: _passwordController),

              CountryPhoneInputField(
                phoneController: _phoneController,
                validator: (value) => Validators.validatePhone(value),
                onChanged: _onPhoneChanged,
              ),

              CustomElevatedButton(
                res: res,
                titleColor: AppColors.neutral100,
                buttonColor: AppColors.neutral900,
                title: state.status == AppStatus.loading
                    ? loadingWidget()
                    : Text(
                        "SignUp",
                        style: AppTextStyles.bodyLarge().copyWith(
                          color: AppColors.neutral100,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                onPressed: state.status == AppStatus.loading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          // استخدام القيم المحفوظة بدون الحاجة لـ setState
                          final registerRequest = RegisterRequestEntity(
                            fullName: _fullNameController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            countryCode: _countryCode.trim(),
                            phoneNumber: _phoneNumber.trim(),
                          );
                          context.read<AuthCubit>().register(registerRequest);
                        }
                      },
              ),

              // Login Button
              CustomElevatedButton(
                res: res,
                titleColor: AppColors.black,
                buttonColor: AppColors.neutral100,
                title: Text(
                  "Login",
                  style: AppTextStyles.bodyLarge().copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: state.status == AppStatus.loading
                    ? null
                    : () {
                        Navigator.pushNamed(context, AppRouter.loginRoute);
                      },
              ),
            ],
          ),
        );
      },
    );
  }
}