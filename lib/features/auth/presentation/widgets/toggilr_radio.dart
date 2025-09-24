import 'package:car_app/core/utils/app_color.dart';
import 'package:flutter/material.dart';

class ToggleRadio extends StatefulWidget {
  final int initialValue; // 0 or 1
  final ValueChanged<int> onChanged; // callback

  const ToggleRadio({
    super.key,
    this.initialValue = 0,
    required this.onChanged,
  });

  @override
  State<ToggleRadio> createState() => _ToggleRadioState();
}

class _ToggleRadioState extends State<ToggleRadio> {
  late int _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  void _updateValue(int val) {
    setState(() => _selectedValue = val);
    widget.onChanged(val); // 🔥 يبعته للـ parent
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Radio 0 (False)
        GestureDetector(
          onTap: () => _updateValue(0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
            decoration: BoxDecoration(
              color: _selectedValue == 0
                  ? Colors.red.withOpacity(0.1)
                  : Colors.transparent,
              border: Border.all(
                color: _selectedValue == 0 ? Colors.red : AppColors.neutral400,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Radio<int>(
                  value: 0,
                  groupValue: _selectedValue,
                  onChanged: (val) => _updateValue(val!),
                  activeColor: Colors.red,
                ),
                const Text("False"),
              ],
            ),
          ),
        ),

        GestureDetector(
          onTap: () => _updateValue(1),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
            decoration: BoxDecoration(
              color: _selectedValue == 1
                  ? AppColors.neutral100
                  : Colors.transparent,
              border: Border.all(
                color: _selectedValue == 1
                    ? AppColors.neutral900
                    : AppColors.neutral400,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Radio<int>(
                  value: 1,
                  groupValue: _selectedValue,
                  onChanged: (val) => _updateValue(val!),
                  activeColor: AppColors.neutral900,
                ),
                const Text("True"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
