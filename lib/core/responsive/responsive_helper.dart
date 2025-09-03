import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

/// تعداد لأنواع الأجهزة المختلفة
enum DeviceType {
  mobile,
  tablet,
  desktop,
  watch,
  tv,
}

/// تعداد لاتجاه الشاشة
enum ScreenOrientation {
  portrait,
  landscape,
}

/// تعداد لأحجام الشاشات
enum ScreenSize {
  xSmall,   // < 600
  small,    // 600-900
  medium,   // 900-1200
  large,    // 1200-1600
  xLarge,   // > 1600
}

/// كلاس شامل للتعامل مع التصميم المتجاوب
class ResponsiveHelper {
  final BuildContext context;
  late final MediaQueryData _mediaQuery;
  late final Size _screenSize;
  late final double _screenWidth;
  late final double _screenHeight;
  late final double _pixelRatio;
  late final Orientation _orientation;

  ResponsiveHelper(this.context) {
    _mediaQuery = MediaQuery.of(context);
    _screenSize = _mediaQuery.size;
    _screenWidth = _screenSize.width;
    _screenHeight = _screenSize.height;
    _pixelRatio = _mediaQuery.devicePixelRatio;
    _orientation = _mediaQuery.orientation;
  }

  // ===================== الخصائص الأساسية =====================

  /// الحصول على عرض الشاشة
  double get screenWidth => _screenWidth;

  /// الحصول على ارتفاع الشاشة
  double get screenHeight => _screenHeight;

  /// الحصول على حجم الشاشة
  Size get screenSize => _screenSize;

  /// الحصول على نسبة البكسل
  double get pixelRatio => _pixelRatio;

  /// الحصول على اتجاه الشاشة
  Orientation get orientation => _orientation;

  /// التحقق من كون الجهاز في الوضع الطولي
  bool get isPortrait => _orientation == Orientation.portrait;

  /// التحقق من كون الجهاز في الوضع الأفقي
  bool get isLandscape => _orientation == Orientation.landscape;

  /// الحصول على الارتفاع المتاح (بدون شريط الحالة والتنقل)
  double get availableHeight => 
      _screenHeight - _mediaQuery.padding.top - _mediaQuery.padding.bottom;

  /// الحصول على العرض المتاح (بدون الحواف)
  double get availableWidth => 
      _screenWidth - _mediaQuery.padding.left - _mediaQuery.padding.right;

  // ===================== تحديد نوع الجهاز =====================

  /// تحديد نوع الجهاز بناءً على المنصة وحجم الشاشة
  DeviceType get deviceType {
    if (kIsWeb) {
      return _getDeviceTypeBySize();
    }
    
    if (Platform.isAndroid || Platform.isIOS) {
      return _screenWidth < 600 ? DeviceType.mobile : DeviceType.tablet;
    } else if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      return DeviceType.desktop;
    } else {
      return _getDeviceTypeBySize();
    }
  }

  DeviceType _getDeviceTypeBySize() {
    if (_screenWidth < 300) return DeviceType.watch;
    if (_screenWidth < 600) return DeviceType.mobile;
    if (_screenWidth < 1200) return DeviceType.tablet;
    if (_screenWidth > 1800) return DeviceType.tv;
    return DeviceType.desktop;
  }

  /// التحقق من أنواع الأجهزة
  bool get isMobile => deviceType == DeviceType.mobile;
  bool get isTablet => deviceType == DeviceType.tablet;
  bool get isDesktop => deviceType == DeviceType.desktop;
  bool get isWatch => deviceType == DeviceType.watch;
  bool get isTV => deviceType == DeviceType.tv;
  bool get isWeb => kIsWeb;

  // ===================== تحديد حجم الشاشة =====================

  /// تحديد حجم الشاشة
  ScreenSize get screenSizeCategory {
    if (_screenWidth < 600) return ScreenSize.xSmall;
    if (_screenWidth < 900) return ScreenSize.small;
    if (_screenWidth < 1200) return ScreenSize.medium;
    if (_screenWidth < 1600) return ScreenSize.large;
    return ScreenSize.xLarge;
  }

  /// التحقق من أحجام الشاشات
  bool get isXSmall => screenSizeCategory == ScreenSize.xSmall;
  bool get isSmall => screenSizeCategory == ScreenSize.small;
  bool get isMedium => screenSizeCategory == ScreenSize.medium;
  bool get isLarge => screenSizeCategory == ScreenSize.large;
  bool get isXLarge => screenSizeCategory == ScreenSize.xLarge;

  // ===================== الحسابات المتجاوبة =====================

  /// تحويل العرض إلى نسبة مئوية من عرض الشاشة
  double widthPercent(double percent) => _screenWidth * (percent / 100);

  /// تحويل الارتفاع إلى نسبة مئوية من ارتفاع الشاشة
  double heightPercent(double percent) => _screenHeight * (percent / 100);

  /// حساب العرض المتجاوب بناءً على العرض المرجعي
  double responsiveWidth(double width, {double referenceWidth = 375}) {
    return (_screenWidth / referenceWidth) * width;
  }

  /// حساب الارتفاع المتجاوب بناءً على الارتفاع المرجعي
  double responsiveHeight(double height, {double referenceHeight = 812}) {
    return (_screenHeight / referenceHeight) * height;
  }

  /// حساب حجم الخط المتجاوب
  double responsiveFontSize(double fontSize, {double referenceWidth = 375}) {
    return (_screenWidth / referenceWidth) * fontSize;
  }

  /// حساب القيمة بناءً على أصغر بُعد في الشاشة
  double responsiveSize(double size) {
    final double shortestSide = _screenSize.shortestSide;
    return (shortestSide / 375) * size;
  }

  // ===================== القيم الشرطية =====================

  /// إرجاع قيمة مختلفة حسب نوع الجهاز
  T valueByDevice<T>({
    T? mobile,
    T? tablet,
    T? desktop,
    T? watch,
    T? tv,
    required T defaultValue,
  }) {
    switch (deviceType) {
      case DeviceType.mobile:
        return mobile ?? defaultValue;
      case DeviceType.tablet:
        return tablet ?? defaultValue;
      case DeviceType.desktop:
        return desktop ?? defaultValue;
      case DeviceType.watch:
        return watch ?? defaultValue;
      case DeviceType.tv:
        return tv ?? defaultValue;
    }
  }

  /// إرجاع قيمة مختلفة حسب حجم الشاشة
  T valueByScreenSize<T>({
    T? xSmall,
    T? small,
    T? medium,
    T? large,
    T? xLarge,
    required T defaultValue,
  }) {
    switch (screenSizeCategory) {
      case ScreenSize.xSmall:
        return xSmall ?? defaultValue;
      case ScreenSize.small:
        return small ?? defaultValue;
      case ScreenSize.medium:
        return medium ?? defaultValue;
      case ScreenSize.large:
        return large ?? defaultValue;
      case ScreenSize.xLarge:
        return xLarge ?? defaultValue;
    }
  }

  /// إرجاع قيمة مختلفة حسب الاتجاه
  T valueByOrientation<T>({
    required T portrait,
    required T landscape,
  }) {
    return isPortrait ? portrait : landscape;
  }

  // ===================== التخطيطات المتجاوبة =====================

  /// تحديد عدد الأعمدة في الشبكة بناءً على عرض الشاشة
  int getGridColumns({
    int mobileColumns = 2,
    int tabletColumns = 3,
    int desktopColumns = 4,
  }) {
    return valueByDevice(
      mobile: mobileColumns,
      tablet: tabletColumns,
      desktop: desktopColumns,
      defaultValue: mobileColumns,
    );
  }

  /// تحديد المساحات الجانبية المتجاوبة
  EdgeInsets getResponsivePadding({
    double mobile = 16.0,
    double tablet = 24.0,
    double desktop = 32.0,
  }) {
    final padding = valueByDevice(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      defaultValue: mobile,
    );
    return EdgeInsets.all(padding);
  }

  /// تحديد المسافات بين العناصر
  double getResponsiveSpacing({
    double mobile = 8.0,
    double tablet = 12.0,
    double desktop = 16.0,
  }) {
    return valueByDevice(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      defaultValue: mobile,
    );
  }

  // ===================== أحجام الخطوط المتجاوبة =====================

  /// الحصول على أحجام الخطوط المتجاوبة
  TextStyle getResponsiveTextStyle({
    required double baseFontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    final responsiveSize = responsiveFontSize(baseFontSize);
    return TextStyle(
      fontSize: responsiveSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  /// أحجام خطوط محددة مسبقاً
  TextStyle get headlineTextStyle => getResponsiveTextStyle(
    baseFontSize: 32,
    fontWeight: FontWeight.bold,
  );

  TextStyle get titleTextStyle => getResponsiveTextStyle(
    baseFontSize: 24,
    fontWeight: FontWeight.w600,
  );

  TextStyle get subtitleTextStyle => getResponsiveTextStyle(
    baseFontSize: 18,
    fontWeight: FontWeight.w500,
  );

  TextStyle get bodyTextStyle => getResponsiveTextStyle(
    baseFontSize: 16,
    fontWeight: FontWeight.normal,
  );

  TextStyle get captionTextStyle => getResponsiveTextStyle(
    baseFontSize: 14,
    fontWeight: FontWeight.w400,
  );

  // ===================== الطرق المساعدة =====================

  /// التحقق من كون الشاشة صغيرة (موبايل أو أصغر)
  bool get isSmallScreen => _screenWidth < 600;

  /// التحقق من كون الشاشة متوسطة (تابلت)
  bool get isMediumScreen => _screenWidth >= 600 && _screenWidth < 1200;

  /// التحقق من كون الشاشة كبيرة (ديسكتوب)
  bool get isLargeScreen => _screenWidth >= 1200;

  /// الحصول على نسبة العرض إلى الارتفاع
  double get aspectRatio => _screenWidth / _screenHeight;

  /// التحقق من الشاشة العريضة
  bool get isWideScreen => aspectRatio > 1.5;

  /// الحصول على الكثافة النصية
  double get textScaleFactor => _mediaQuery.textScaler.scale(1.0);

  /// التحقق من وضع الإمكانيات المحدودة
  bool get isAccessibilityMode => textScaleFactor > 1.3;

  /// معلومات إضافية للتشخيص
  Map<String, dynamic> get debugInfo => {
    'screenWidth': _screenWidth,
    'screenHeight': _screenHeight,
    'deviceType': deviceType.toString(),
    'screenSize': screenSizeCategory.toString(),
    'orientation': _orientation.toString(),
    'pixelRatio': _pixelRatio,
    'textScaleFactor': textScaleFactor,
    'platform': kIsWeb ? 'Web' : Platform.operatingSystem,
  };

  /// طباعة معلومات الشاشة للتشخيص
  void printDebugInfo() {
    debugInfo.forEach((key, value) {
      print('$key: $value');
    });
  }
}

/// ويدجت مساعد للتصميم المتجاوب
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ResponsiveHelper responsive) builder;

  const ResponsiveBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    return builder(context, responsive);
  }
}

/// ويدجت للتخطيط المتجاوب المتقدم
class ResponsiveLayout extends StatelessWidget {
  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? watch;
  final Widget? tv;
  final Widget? defaultWidget;

  const ResponsiveLayout({
    Key? key,
    this.mobile,
    this.tablet,
    this.desktop,
    this.watch,
    this.tv,
    this.defaultWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    
    return responsive.valueByDevice(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      watch: watch,
      tv: tv,
      defaultValue: defaultWidget ?? mobile ?? Container(),
    );
  }
}

/// ويدجت للنصوص المتجاوبة
class ResponsiveText extends StatelessWidget {
  final String text;
  final double baseFontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const ResponsiveText(
    this.text, {
    Key? key,
    required this.baseFontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    
    return Text(
      text,
      style: responsive.getResponsiveTextStyle(
        baseFontSize: baseFontSize,
        fontWeight: fontWeight,
        color: color,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}



extension ResponsiveShortcuts on ResponsiveHelper {
  /// حجم خط متجاوب مختصر (scale text)
  double sp(
    double size, {
    double referenceWidth = 375,
    bool includeTextScale = false, // لو عايز تحترم تكبير الخط من الإعدادات
    double min = 0,
    double? max,
  }) {
    double v = responsiveFontSize(size, referenceWidth: referenceWidth);
    if (includeTextScale) v = v * textScaleFactor;
    if (v < min) v = min;
    if (max != null && v > max) v = max;
    return v;
  }

  /// اختصارات إضافية مفيدة
  double wp(double percent) => widthPercent(percent);
  double hp(double percent) => heightPercent(percent);
  double rw(double width, {double referenceWidth = 375}) =>
      responsiveWidth(width, referenceWidth: referenceWidth);
  double rh(double height, {double referenceHeight = 812}) =>
      responsiveHeight(height, referenceHeight: referenceHeight);
  double rs(double size) => responsiveSize(size);
}
