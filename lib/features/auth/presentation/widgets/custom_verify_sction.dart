import 'package:car_app/core/extention/adaptive_input_field.dart';
import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/validators.dart';
import 'package:car_app/core/widget/cutsom_eleveted_button.dart';
import 'package:car_app/features/auth/presentation/widgets/custom_country_text_form_field.dart';
import 'package:flutter/material.dart';





class CustomVerifySection extends StatefulWidget {
  const CustomVerifySection({super.key});

  @override
  State<CustomVerifySection> createState() => _CustomVerifySectionState();
}

final TextEditingController _phoneController = TextEditingController();

class _CustomVerifySectionState extends State<CustomVerifySection> {
  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomCountryTextFormField(),
        SizedBox(height: res.rh(10)),
        AdaptiveInputField(
          controller: _phoneController,
          context: context,
          hintText: 'Phone Number',
          validate: (value) => Validators.validatePhone(value),
        ),
        SizedBox(height: res.rh(20)),
        CustomElevatedButton(
          res: res,
          titleColor: AppColors.white,
          buttonColor: AppColors.neutral900,
          title: "Continue",
        ),
      ],
    );
  }
}
