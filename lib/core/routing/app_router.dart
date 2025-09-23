import 'package:car_app/features/auth/presentation/pages/login_screen.dart';
import 'package:car_app/features/auth/presentation/pages/otp_screen.dart';
import 'package:car_app/features/auth/presentation/pages/reset_password_screen.dart';
import 'package:car_app/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:car_app/features/auth/presentation/pages/verfiy_phone_screen.dart';
import 'package:car_app/features/splash/presentation/pages/splash_page_view_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const splashRoute = '/splash';
  static const loginRoute = '/login';
  static const signUpRoute = '/signin';
  static const forgetPasswordRoute = "/forgetPassword";
  static const mainRoute = "/home";
  static const searchRoute = "/search";
  static const filterSearchRoute = "/filterSearch";
  static const verifyPhoneRoute = "/verifyPhone";
  static const otpRoute = "/otp";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => SplashPageView());

      case loginRoute:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),   
        );

      case signUpRoute:
        return MaterialPageRoute(builder: (_) => SignUpScreen());

      case verifyPhoneRoute:
        return MaterialPageRoute(builder: (_) => VerifyPhoneScreen());

      case otpRoute:
        final token = settings.arguments as String?;
        if (token != null) {
          return MaterialPageRoute(
            builder: (_) => OtpScreen(resetToken: token),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(
                child: Text("Error: Reset token is required"),
              ),
            ),
          );
        }

      case forgetPasswordRoute: // إضافة route للـ reset password
        return MaterialPageRoute(builder: (_) => const ResetPassword());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Page not found")),
          ),
        );
    }
  }
}