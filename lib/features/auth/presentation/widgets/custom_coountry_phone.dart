import 'package:car_app/core/extention/adaptive_input_field.dart';
import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/validators.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class CountryPhoneInputField extends StatefulWidget {
  final TextEditingController phoneController;
  final Function(String fullPhone, String countryCode, String phoneNumber)? onChanged;
  final String? Function(String?)? validator;

  const CountryPhoneInputField({
    super.key,
    required this.phoneController,
    this.onChanged,
    this.validator,
  });

  @override
  State<CountryPhoneInputField> createState() => _CountryPhoneInputFieldState();
}

class _CountryPhoneInputFieldState extends State<CountryPhoneInputField> {
  String _countryCode = "+20";

  @override
  void initState() {
    super.initState();
    // إضافة listener للـ phone controller
    widget.phoneController.addListener(_onPhoneNumberChanged);
  }

  @override
  void dispose() {
    widget.phoneController.removeListener(_onPhoneNumberChanged);
    super.dispose();
  }

  void _onPhoneNumberChanged() {
    // استدعاء الـ callback عند تغيير رقم الهاتف
    final phoneNumber = widget.phoneController.text;
    final fullPhone = "$_countryCode$phoneNumber";
    
    widget.onChanged?.call(fullPhone, _countryCode, phoneNumber);
  }

  void _onCountryCodeChanged(CountryCode code) {
    setState(() {
      _countryCode = code.dialCode ?? "+20";
    });
    
    // استدعاء الـ callback عند تغيير كود الدولة
    final phoneNumber = widget.phoneController.text;
    final fullPhone = "$_countryCode$phoneNumber";
    
    widget.onChanged?.call(fullPhone, _countryCode, phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return AdaptiveInputField(
      controller: widget.phoneController,
      context: context,
      hintText: 'Phone',
      prefix: Container(
        height: res.responsiveHeight(55),
        decoration: BoxDecoration(
          color: AppColors.neutral300,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
        ),
        child: CountryCodePicker(
          onChanged: _onCountryCodeChanged,
          initialSelection: 'EG',
          favorite: ['+20', 'EG'],
          showCountryOnly: false,
          showOnlyCountryWhenClosed: false,
          alignLeft: false,
          padding: EdgeInsets.zero,
          textStyle: const TextStyle(
            color: AppColors.neutral900,
          ),
        ),
      ),
      validate: widget.validator ?? (value) => Validators.validatePhone(value),
    );
  }
}