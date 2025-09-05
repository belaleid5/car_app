import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class CustomFormVerification extends StatelessWidget {
  const CustomFormVerification({super.key});

  @override
  Widget build(BuildContext context) {
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
        defaultPinTheme: defaultPinTheme,
        separatorBuilder: (index) => Spacer(),

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