import 'package:flutter/material.dart';
import 'package:pregmaa/Screens/HomePage/homeScreen.dart';
import 'package:pregmaa/Screens/LoginPage/loginPage.dart';
import 'package:pregmaa/Screens/OnBoardingPage/onboardingScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Onboardingscreen(),
    );
  }
}
