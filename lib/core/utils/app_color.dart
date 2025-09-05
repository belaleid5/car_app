import 'dart:ui';

class AppColors {
  // Primary Colors
  static const Color primary50 = Color(0xFFEFF6FF);
  static const Color primary100 = Color(0xFFDBEAFE);
  static const Color primary200 = Color(0xFFBFDBFE);
  static const Color primary300 = Color(0xFF93C5FD);
  static const Color primary400 = Color(0xFF60A5FA);
  static const Color primary500 = Color(0xFF3B82F6);
  static const Color primary600 = Color(0xFF2563EB);
  static const Color primary700 = Color(0xFF1D4ED8);
  static const Color primary800 = Color(0xFF1E40AF);
  static const Color primary900 = Color(0xFF1E3A8A);
  
  // Neutral/Gray Colors
  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFE5E5E5);
  static const Color neutral300 = Color(0xFFD4D4D4);
  static const Color neutral400 = Color(0xFFA3A3A3);
  static const Color neutral500 = Color(0xFF737373);
  static const Color neutral600 = Color(0xFF525252);
  static const Color neutral700 = Color(0xFF404040);
  static const Color neutral800 = Color(0xFF262626);
  static const Color neutral900 = Color(0xFF21292B);
  
  // Success Colors
  static const Color success50 = Color(0xFFF0FDF4);
  static const Color success100 = Color(0xFFDCFCE7);
  static const Color success500 = Color(0xFF22C55E);
  static const Color success600 = Color(0xFF16A34A);
  
  // Warning Colors  
  static const Color warning50 = Color(0xFFFEFDF8);
  static const Color warning100 = Color(0xFFFEF3C7);
  static const Color warning500 = Color(0xFFEAB308);
  static const Color warning600 = Color(0xFFCA8A04);
  
  // Error Colors
  static const Color error50 = Color(0xFFFEF2F2);
  static const Color error100 = Color(0xFFFECECE);
  static const Color error500 = Color(0xFFEF4444);
  static const Color error600 = Color(0xFFDC2626);
  
  // Common Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  
  // Semantic Colors
  static Color get background => neutral50;
  static Color get surface => white;
  static Color get onPrimary => white;
  static Color get onSurface => neutral900;
  static Color get onBackground => neutral900;
}
