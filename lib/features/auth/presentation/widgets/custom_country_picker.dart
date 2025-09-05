import 'package:car_app/core/utils/app_color.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class CountryTextFormField extends StatefulWidget {
  final Country? initialCountry;
  final Function(Country?)? onChanged;
  final Function(Country?)? onSaved;
  final String? Function(Country?)? validator;
  final String? hintText;
  final EdgeInsets? padding;

  const CountryTextFormField({
    super.key,
    this.initialCountry,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.hintText = 'Country',
    this.padding,
  });

  @override
  State<CountryTextFormField> createState() => _CountryTextFormFieldState();
}

class _CountryTextFormFieldState extends State<CountryTextFormField> {
  Country? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = widget.initialCountry;
  }

  void _showCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16, color: Colors.black87),
        bottomSheetHeight: MediaQuery.of(context).size.height * 0.7,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(0.2)),
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Search country',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: const BorderSide(color: AppColors.black, width: 0.2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.67),
            borderSide: const BorderSide(color: AppColors.black, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.67),
            borderSide: const BorderSide(color: Colors.blue, width: 0.5),
          ),
        ),
      ),
      onSelect: (Country country) {
        setState(() {
          _selectedCountry = country;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(country);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormField<Country>(
      initialValue: _selectedCountry,
      onSaved: widget.onSaved,
      validator: widget.validator,
      builder: (FormFieldState<Country> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: _showCountryPicker,
              child: Container(
                padding:
                    widget.padding ??
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: state.hasError ? Colors.red : AppColors.black,
                    width: 0.3,
                  ),
                  borderRadius: BorderRadius.circular(10.67),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    // Flag
                    if (_selectedCountry != null) ...[
                      Text(
                        _selectedCountry!.flagEmoji,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 12),
                    ] else ...[
                      Container(
                        width: 20,
                        height: 14,
                        decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],

                    // Country name or hint
                    Expanded(
                      child: Text(
                        _selectedCountry?.name ?? widget.hintText!,
                        style: TextStyle(
                          fontSize: 16,
                          color:
                              _selectedCountry != null
                                  ? Colors.black87
                                  : AppColors.black,
                        ),
                      ),
                    ),

                    // Dropdown icon
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.black,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),

            // Error text
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 16),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
