import 'package:car_app/core/utils/app_color.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({
    super.key,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}
bool _isChecked = false;

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      isError: _isChecked,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      checkColor: AppColors.error50,
      activeColor: AppColors.neutral800,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      value: _isChecked,
      onChanged: (bool? value) {
        setState(() {
          _isChecked = value!;
        });
      },
    );
  }
}
