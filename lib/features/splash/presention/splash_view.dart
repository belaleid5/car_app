import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_images.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/features/onboarding/presentation/pages/onbording_screen.dart';
import 'package:car_app/features/splash/presention/widget/custom_animated-builder.dart';
import 'package:car_app/features/splash/presention/widget/text_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:math';

import 'package:flutter_svg/svg.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _imageController;
  late AnimationController _textController;
  late AnimationController _progressController;
  late AnimationController _backgroundController;
  
  late Animation<double> _imageScale;
  late Animation<double> _imageOpacity;
  late Animation<Offset> _textSlide;
  late Animation<double> _textOpacity;
  late Animation<double> _progressValue;
  
  String _loadingText = '  Loading Download Cars...';
  double _progress = 0.0;
  
  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startSplashSequence();
  }
  
  void _initAnimations() {
    _imageController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _textController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );
    
    // متحكم شريط التقدم
    _progressController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    
    _backgroundController = AnimationController(
      duration: Duration(seconds: 6),
      vsync: this,
    )..repeat();
    
    _imageScale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _imageController,
      curve: Curves.elasticOut,
    ));
    
    _imageOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _imageController,
      curve: Curves.easeIn,
    ));
    
    _textSlide = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOut,
    ));
    
    _textOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    ));
    
    // حركة شريط التقدم
    _progressValue = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));
    
    // حركة الخلفية
  }
  
  void _startSplashSequence() async {
    HapticFeedback.lightImpact();
    
    _imageController.forward();
    
    await Future.delayed(Duration(milliseconds: 800));
    _textController.forward();
    
    await Future.delayed(Duration(milliseconds: 500));
    _progressController.forward();
    _updateLoadingProgress();
    
    await Future.delayed(Duration(seconds: 4));
    _navigateToHome();
  }
  
 void _updateLoadingProgress() {
  Timer.periodic(const Duration(milliseconds: 100), (timer) {
    if (_progress >= 1.0) {
      timer.cancel();
      setState(() {
        _loadingText = 'Welcome to Car Rental!';
      });
      HapticFeedback.mediumImpact();
      return;
    }

    setState(() {
      _progress = _progressValue.value;

      if (_progress < 0.3) {
        _loadingText = 'Loading available cars...';
      } else if (_progress < 0.6) {
        _loadingText = 'Setting up rental services...';
      } else if (_progress < 0.9) {
        _loadingText = 'Finalizing setup...';
      } else {
        _loadingText = 'Welcome to Car Rental!';
      }
    });
  });


  }
  
  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            OnBoardingScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 800),
      ),
    );
  }
  
  @override
  void dispose() {
    _imageController.dispose();
    _textController.dispose();
    _progressController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }
  
  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white, // ✅ الخلفية بيضاء
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _imageController,
            builder: (context, child) {
              return Transform.scale(
                scale: _imageScale.value,
                child: Opacity(
                  opacity: _imageOpacity.value,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.neutral900,
                    child: SvgPicture.asset(
                      height: 80,
                      AppImages.carSvg,
                    color: AppColors.white,
                    
                    ))
                ),
              );
            },
          ),

          const SizedBox(height: 40),

          TextAinmation(textSlide: _textSlide, textOpacity: _textOpacity),

          const SizedBox(height: 60),

          CustomAnimateBuilder(progressController: _progressController, progressValue: _progressValue, loadingText: _loadingText),
        ],
      ),
    ),
  );
}

}



