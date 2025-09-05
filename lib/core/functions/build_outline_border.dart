 import 'package:car_app/core/utils/app_color.dart';
import 'package:flutter/material.dart';

OutlineInputBorder buildOutlineBorder() {
    return OutlineInputBorder(
            
              borderSide: BorderSide(
                color: AppColors.black), // Color for radius border
              borderRadius: BorderRadius.circular(32),
            );
  }







  OutlineInputBorder buildOutlineBorderDeskTop() {
    return OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.black,
    ), 
              borderRadius: BorderRadius.circular(6),
            );
  }