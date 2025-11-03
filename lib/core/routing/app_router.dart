import 'package:car_app/features/auth_feature/presentation/pages/login_screen.dart';
import 'package:car_app/features/auth_feature/presentation/pages/otp_confirm_password_screen.dart';
import 'package:car_app/features/auth_feature/presentation/pages/otp_phone_verify.dart';
import 'package:car_app/features/auth_feature/presentation/pages/reset_password_screen.dart';
import 'package:car_app/features/auth_feature/presentation/pages/sign_up_screen.dart';
import 'package:car_app/features/cars_feature/car_details/presentaion/pages/car_details_screen.dart';
import 'package:car_app/features/cars_feature/home/presentaion/pages/home_screen.dart';
import 'package:car_app/features/cars_feature/search_car/presentaion/screens/search_screen.dart';
import 'package:car_app/features/onboarding/presentation/pages/onbording_page_view_screen.dart';
import 'package:car_app/features/splash/presention/splash_view.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const splashRoute = '/splash';
  static const loginRoute = '/login';
  static const signUpRoute = '/signin';
  static const forgetPasswordRoute = "/forgetPassword";
  static const mainRoute = "/mainRoute";
  static const homeRoute = "/homeRoute";

  static const searchRoute = "/search";
  static const filterSearchRoute = "/filterSearch";
  static const verifyPhoneRoute = "/verifyPhone";
  static const verifyConfirmPasswordRoute = "/veriyConfirmPasswordRoute";
  static const otpRoute = "/otp";
  static const onBoarding = "/onBoard";
  static const carDetilesHomeRoute = "/carDetilesHomeRoute";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case onBoarding:
        return MaterialPageRoute(builder: (_) => OnBoardingPageView());

      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case signUpRoute:
        return MaterialPageRoute(builder: (_) => SignUpScreen());

      case verifyPhoneRoute:
        final verifyToken = settings.arguments as String?;
        print('Router - verifyToken: $verifyToken');

        return MaterialPageRoute(
          builder: (_) => OtpVerifyCodePhoneScreen(),
          settings: settings,
        );

      case otpRoute:
        final token = settings.arguments as String?;
        if (token != null) {
          return MaterialPageRoute(
            builder: (_) => OtpConfirmPasswordScreen(resetToken: token),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text("Error: Reset token is required")),
            ),
          );
        }

      case forgetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ResetPassword());

      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case searchRoute:
        return MaterialPageRoute(builder: (_) => SearchScreen());
      case carDetilesHomeRoute:
        return MaterialPageRoute(
            builder: (_) => const CarDetailsScreen(), settings: settings);

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("Page not found"))),
        );
    }
  }
}
