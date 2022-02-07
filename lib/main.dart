import 'package:a_new_project_in_flutter/screens/home_page.dart';
import 'package:a_new_project_in_flutter/screens/login_page.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
    return MaterialApp(
      title: 'My Application',
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: 500,
      nextScreen: const LoginPage(),
      splash: Image.asset(
        'images/app_logo_2x.png',
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.contain,
      ),
      duration: 3000,
      splashTransition: SplashTransition.scaleTransition,
    );
  }
}
