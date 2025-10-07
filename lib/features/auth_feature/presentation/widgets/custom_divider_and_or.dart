import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:flutter/material.dart';

class CustomDividerAndOR extends StatelessWidget {
  const CustomDividerAndOR({
    super.key,
    required this.res,
  });

  final ResponsiveHelper res;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: Divider(color: Colors.grey, thickness: 1)),
      SizedBox(width: res.rh(10)),
      Text('OR', style: AppTextStyles.bodyMedium()),
      SizedBox(width: res.rh(10)),
      Expanded(child: Divider(color: Colors.grey, thickness: 1)),
    ],);
  }
}
