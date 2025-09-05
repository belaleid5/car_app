import 'package:car_app/features/auth/presentation/widgets/custom_country_picker.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class CustomCountryTextFormField extends StatefulWidget {
  const CustomCountryTextFormField({super.key});

  @override
  State<CustomCountryTextFormField> createState() =>
      _CustomCountryTextFormFieldState();
}

Country? _selectedCountry;

class _CustomCountryTextFormFieldState
    extends State<CustomCountryTextFormField> {
  @override
  Widget build(BuildContext context) {
    return CountryTextFormField(
      hintText: 'Country',
      onChanged: (country) {
        setState(() {
          _selectedCountry = country;
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