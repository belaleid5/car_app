import 'package:car_app/core/di/server_locator.dart';
import 'package:car_app/core/routing/app_router.dart';
import 'package:flutter/material.dart';

void main()async {
   WidgetsFlutterBinding.ensureInitialized();
  // Setup dependency injection
  await setupDependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       onGenerateRoute: AppRouter.onGenerate,
       initialRoute: AppRouter.splashRoute,
      
    );
  }
}

