
import 'package:car_app/features/auth/presentation/pages/login_screen.dart';
import 'package:car_app/features/splash/presentation/pages/splash_page_view_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const splashRoute = '/splash';
  static const loginRoute = '/login';
  static const signUpRoute = '/signin';
  static const forgetPasword = "/forgetPassword";
  static const setPassword = '/setPassword';
  static const mainRoute = "/home";
  static const searchRoute = "/search";
  static const filterSearchRoute = "/filterSearch";



  static MaterialPageRoute onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
      
        return MaterialPageRoute(builder: (_) => SplashPageView());
     case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
  