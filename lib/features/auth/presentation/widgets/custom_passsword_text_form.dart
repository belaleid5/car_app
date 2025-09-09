import 'package:car_app/core/extention/adaptive_input_field.dart';
import 'package:car_app/core/utils/validators.dart';
import 'package:flutter/material.dart';

class CustomPasswordFormField extends StatefulWidget {
  const CustomPasswordFormField({
    super.key,
    required TextEditingController passwordController,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  State<CustomPasswordFormField> createState() =>
      _CustomPasswordFormFieldState();
}

class _CustomPasswordFormFieldState extends State<CustomPasswordFormField> {
  bool _isObscure = true; 

  @override
  Widget build(BuildContext context) {
    return AdaptiveInputField(
      controller: widget._passwordController,
      isPassword: _isObscure,
      context: context,
      hintText: 'Password',
      keyboardType: TextInputType.visiblePassword,
      maxLines: 1,
      suffix: GestureDetector(
        onTap: () {
          setState(() {
            _isObscure = !_isObscure;
          });
        },
        child: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
      ),
      validate: (value) => Validators.validatePassword(value),
    );
  }
}