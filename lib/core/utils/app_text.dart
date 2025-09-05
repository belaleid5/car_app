import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:flutter/material.dart';













abstract class AppTextStyles {

 static const String primaryFont = 'Roboto';
  
  // Font Weights
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;





static TextStyle h1({Color? color}) => TextStyle(
    fontFamily: primaryFont,
    fontSize: 72,
    fontWeight: bold,
    color: color,
    height: 1.2,
  );
  
  static TextStyle h2({Color? color}) => TextStyle(
    fontFamily: primaryFont,
    fontSize: 60,
    fontWeight: bold,
    color: color,
    height: 1.2,
  );
  
  static TextStyle h3({Color? color}) => TextStyle(
    fontFamily: primaryFont,
    fontSize: 48,
    fontWeight: bold,
    color: color,
    height: 1.2,
  );
  
  static TextStyle h4({Color? color}) => TextStyle(
    fontFamily: primaryFont,
    fontSize: 36,
    fontWeight: bold,
    color: color,
    height: 1.2,
  );
  
  static TextStyle h5({Color? color}) => TextStyle(
    fontFamily: primaryFont,
    fontSize: 30,
    fontWeight: bold,
    color: color,
    height: 1.2,
  );
  
  static TextStyle h6({Color? color}) => TextStyle(
    fontFamily: primaryFont,
    fontSize: 24,
    fontWeight: bold,
    color: color,
    height: 1.2,
  );
  
  // Body Text
  static TextStyle bodyLarge({Color? color}) => TextStyle(
    fontFamily: primaryFont,
    fontSize: 18,
    fontWeight: regular,
    color: color,
    height: 1.5,
  );
  
  static TextStyle bodyMedium({Color? color}) => TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: regular,
    color: color,
    height: 1.5,
  );
  
  static TextStyle bodySmall({Color? color}) => TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: regular,
    color: color,
    height: 1.5,
  );
  
  // Labels
  static TextStyle labelLarge({Color? color}) => TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: medium,
    color: color,
    height: 1.4,
  );
  
  static TextStyle labelMedium({Color? color}) => TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: medium,
    color: color,
    height: 1.4,
  );
  
  static TextStyle labelSmall({Color? color}) => TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: medium,
    color: color,
    height: 1.4,
  );
  
  // Caption & Overline
  static TextStyle caption({Color? color}) => TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: regular,
    color: color,
    height: 1.3,
  );
  
  static TextStyle overline({Color? color}) => TextStyle(
    fontFamily: primaryFont,
    fontSize: 10,
    fontWeight: medium,
    color: color,
    height: 1.6,
    letterSpacing: 1.5,
  );

}
