import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/routing/app_router.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/app_text.dart';
import 'package:car_app/core/widget/cutsom_eleveted_button.dart';
import 'package:car_app/features/splash/presentation/pages/splash_screen_tow.dart';
import 'package:flutter/material.dart';

import 'splash_screen.dart';

class SplashPageView extends StatefulWidget {
  const SplashPageView({super.key});

  @override
  State<SplashPageView> createState() => _SplashPageViewState();
}

class _SplashPageViewState extends State<SplashPageView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // --- PageView ---
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            children: const [SplashScreen(), SplashScreenTow()],
          ),

          Positioned(
            bottom: res.rh(120),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                2,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: res.rw(5)),
                  height: res.rh(10),
                  width: _currentPage == index ? res.rw(30) : res.rw(10),
                  decoration: BoxDecoration(
                    color:
                        _currentPage == index
                            ? AppColors.black
                            : AppColors.neutral50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: res.rh(30),
            left: res.rw(16),
            right: res.rw(16),
            child: CustomElevatedButton(
              res: res,
              onPressed: () {
                if (_currentPage < 1) {
                  _pageController.animateToPage(
                    _currentPage + 1,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                } else {
                  Navigator.pushReplacementNamed(context, AppRouter.loginRoute);
                }
              }, titleColor: AppColors.white, 
              buttonColor: AppColors.neutral900, 
              title:
                
                  Text(
        "Get Started",
        style: AppTextStyles.bodyLarge().copyWith(
          color:  Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
            ),
          ),
        ],
      ),
    );
  }
}
