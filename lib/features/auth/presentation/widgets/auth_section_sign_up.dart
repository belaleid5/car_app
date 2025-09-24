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
import 'package:car_app/features/auth/domain/entities/location_entity.dart';
import 'package:car_app/features/auth/domain/entities/register_request_entity.dart';
import 'package:car_app/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:car_app/features/auth/presentation/blocs/auth_states.dart';
import 'package:car_app/features/auth/presentation/widgets/custom_coountry_phone.dart';
import 'package:car_app/features/auth/presentation/widgets/custom_passsword_text_form.dart';
import 'package:car_app/features/auth/presentation/widgets/custom_select_location.dart';
import 'package:car_app/features/auth/presentation/widgets/toggilr_radio.dart';
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
  final TextEditingController _locationController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _fullPhoneNumber = '';
  String _countryCode = '+20';
  String _phoneNumber = '';
  LocationEntity? _selectedLocation;
  bool _availableToCreateCar = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _onPhoneChanged(
    String fullPhone,
    String countryCode,
    String phoneNumber,
  ) {
    _fullPhoneNumber = fullPhone;
    _countryCode = countryCode;
    _phoneNumber = phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AppStatus.success && state.tokens != null) {
          CustomToast.show(
            context,
            state.message ?? 'Registration successful!',
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRouter.loginRoute,
            (route) => false,
          );
        } else if (state.status == AppStatus.failure) {
          CustomToast.show(context, state.message ?? 'An error occurred!');
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            spacing: 18,
            children: [
              AdaptiveInputField(
                controller: _fullNameController,
                context: context,
                hintText: 'Full Name',
                validate: (value) => Validators.validateFullName(value),
              ),

              AdaptiveInputField(
                controller: _emailController,
                context: context,
                hintText: 'Email',
                validate: (value) => Validators.validateEmail(value),
              ),

              CustomPasswordFormField(
                passwordController: _passwordController,
                validate: (value) => Validators.validatePassword(value),
              ),

              CountryPhoneInputField(
                phoneController: _phoneController,
                validator: (value) => Validators.validatePhone(value),
                onChanged: _onPhoneChanged,
              ),

              CustomSelectLocation(
                locationController: _locationController,
                onLocationSelected: (selectedLocation) {
                  setState(() {
                    _selectedLocation = selectedLocation;
                    _locationController.text = selectedLocation.name;
                  });
                },
              ),
              Text(
                "Available To Create Car",
                style: AppTextStyles.bodyLarge().copyWith(
                  color: AppColors.neutral900,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ToggleRadio(
                onChanged: (int value) {
                  setState(() {
                    _availableToCreateCar = value == 1;
                  });
                },
              ),
              CustomElevatedButton(
                res: res,
                titleColor: AppColors.neutral100,
                buttonColor: AppColors.neutral900,
                title: state.status == AppStatus.registering
                    ? loadingWidget()
                    : Text(
                        "SignUp",
                        style: AppTextStyles.bodyLarge().copyWith(
                          color: AppColors.neutral100,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                onPressed: state.status == AppStatus.registering
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          final registerRequest = RegisterRequestEntity(
                            fullName: _fullNameController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            countryCode: _countryCode.trim(),
                            phoneNumber: _phoneNumber.trim(),
                            locationId: _selectedLocation!.id,
                            availableToCreateCar: _availableToCreateCar,
                          );
                          context.read<AuthCubit>().register(registerRequest);
                        }
                      },
              ),
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
                onPressed: state.status == AppStatus.registering
                    ? null
                    : () => Navigator.pushNamed(context, AppRouter.loginRoute),
              ),
            ],
          ),
        );
      },
    );
  }
}
