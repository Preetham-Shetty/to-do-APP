import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/pages/onboarding_screen.dart';
import 'package:todoapp/services/googlesignin.dart';
import 'package:todoapp/utils/colors.dart';
import '../utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool visible = true;
  bool skipScreen = false;

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);
    if (seen) {
      setState(() {
        skipScreen = true;
      });
    } else {
      await prefs.setBool('seen', true);
      setState(() {
        skipScreen = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkFirstSeen();
    Future.delayed(const Duration(seconds: 5)).then((value) {
      setState(() {
        visible = false;
      });
    });
    Timer(
        const Duration(seconds: 7),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => skipScreen
                    ? GoogleSigninProvider().handleRoutes()
                    : const OnboardingScreen()),
            (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    Dimensions.init(context: context);
    return Scaffold(
        body: Center(
            child: visible
                ? Lottie.asset('assets/lottie/splash.json',
                    width: Dimensions.screenWidth,
                    height: Dimensions.screenHeight * 0.3)
                : const Text(
                    "Tasker",
                    style: TextStyle(
                        fontSize: 30,
                        color: AppColors.themeColor,
                        fontFamily: 'Splash'),
                  )));
  }
}
