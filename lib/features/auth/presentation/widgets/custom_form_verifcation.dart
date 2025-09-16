import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class CustomFormVerification extends StatelessWidget {
  const CustomFormVerification({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return Center(
      child: Pinput(
        length: 4,
        controller: controller, // ✅ هنا مكانها الصح
        defaultPinTheme: defaultPinTheme,
        separatorBuilder: (index) => SizedBox(width: res.screenWidth * 0.10),
        onCompleted: (pin) {
          debugPrint('✅ Entered PIN is: $pin');
        },
        onChanged: (value) {
          debugPrint('🔄 Current value: $value');
        },
      ),
    );
  }
}
