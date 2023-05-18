import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todoapp/pages/login_page.dart';
import 'package:todoapp/utils/colors.dart';
import 'package:todoapp/utils/dimensions.dart';
import 'package:todoapp/utils/text.dart';
import 'package:lottie/lottie.dart';
import 'package:dots_indicator/dots_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: AppColors.white,
        onPressed: () {
          if (_currentIndex != 2) {
            _pageController.nextPage(
                duration: const Duration(microseconds: 300),
                curve: Curves.linear);
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          }
        },
        child: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: AppColors.black,
        ),
      ),
      body: Stack(
        children: [
          CustomPaint(
            painter: ArcPainter(),
            child: SizedBox(
              width: Dimensions.screenWidth,
              height: Dimensions.screenHeight * 0.7,
            ),
          ),
          Positioned(
            top: 130,
            right: 5,
            left: 5,
            child: Lottie.asset(
              tabs[_currentIndex].animationFile,
              key: Key('${Random().nextInt(999999999)}'),
              width: 600,
              alignment: Alignment.topCenter,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: Dimensions.screenHeight * 0.33,
              child: Column(
                children: [
                  Flexible(
                    child: PageView.builder(
                        controller: _pageController,
                        itemCount: tabs.length,
                        onPageChanged: (value) {
                          setState(() {
                            _currentIndex = value;
                          });
                        },
                        itemBuilder: (context, index) {
                          OnboadringModel tab = tabs[index];
                          return Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: Dimensions.screenWidth * 0.02),
                                child: AppText(
                                  text: tab.title,
                                  fontSize: 25,
                                  fontAlign: TextAlign.center,
                                  fontColor: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'ProximaNova',
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: Dimensions.screenWidth * 0.02),
                                child: AppText(
                                  text: tab.subtitle,
                                  fontSize: 20,
                                  fontAlign: TextAlign.center,
                                  fontColor: AppColors.white,
                                  fontFamily: 'ProximaNova',
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(bottom: Dimensions.screenHeight * 0.05),
                    child: DotsIndicator(
                      dotsCount: tabs.length,
                      position: _currentIndex,
                      decorator: DotsDecorator(
                        size: const Size.square(9.0),
                        activeSize: const Size(30.0, 5.0),
                        activeColor: AppColors.white,
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path redArc = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height - 170)
      ..quadraticBezierTo(
          size.width / 2, size.height, size.width, size.height - 170)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(redArc, Paint()..color = AppColors.tabOne);

    Path whiteArc = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height - 185)
      ..quadraticBezierTo(
          size.width / 2, size.height - 70, size.width, size.height - 185)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(whiteArc, Paint()..color = AppColors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class OnboadringModel {
  final String animationFile;
  final String title;
  final String subtitle;

  OnboadringModel(this.animationFile, this.title, this.subtitle);
}

List<OnboadringModel> tabs = [
  OnboadringModel('assets/lottie/welcome.json', 'Welcome to Tasker!',
      ' your ultimate productivity companion!'),
  OnboadringModel('assets/lottie/accuracy.json', 'Hit your Goals',
      "Create task lists and set due dates to stay on track."),
  OnboadringModel('assets/lottie/rocket.json', 'Get started !',
      "Get started now and achieve more each day"),
];
