import 'package:car_app/features/auth/presentation/widgets/custom_country_picker.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class CustomCountryTextFormField extends StatefulWidget {
  final TextEditingController controller; // هنستقبل controller من برة

  const CustomCountryTextFormField({
    super.key,
    required this.controller,
  });

  @override
  State<CustomCountryTextFormField> createState() =>
      _CustomCountryTextFormFieldState();
}

class _CustomCountryTextFormFieldState
    extends State<CustomCountryTextFormField> {
  Country? _selectedCountry;

  @override
  Widget build(BuildContext context) {
    return CountryTextFormField(
      hintText: 'Country',
      onChanged: (country) {
        setState(() {
          _selectedCountry = country;
          widget.controller.text = country!.countryCode; // نخزن اسم البلد في الـ controller
        });
      },
      validator: (country) {
        if (country == null) {
          return 'Please select a country';
        }
        return null;
      },
    );
  }
}
