import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/services/googlesignin.dart';
import 'package:todoapp/utils/text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(children: [
        CustomPaint(
          painter: ArcPainter(),
          child: SizedBox(
            width: Dimensions.screenWidth,
            height: Dimensions.screenHeight * 0.7,
          ),
        ),
        Positioned(
            top: 80,
            right: 5,
            left: 5,
            child: Column(
              children: [
                Lottie.asset('assets/lottie/login.json'),
                const AppText(
                  text: "Sign-in to Continue",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ProximaNova',
                )
              ],
            )),
        Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
              onTap: () {
                final provider =
                    Provider.of<GoogleSigninProvider>(context, listen: false);
                provider.googleLogIn();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            GoogleSigninProvider().handleRoutes()),
                    (route) => false);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.screenWidth * 0.02,
                    vertical: Dimensions.screenHeight * 0.01),
                width: Dimensions.screenWidth * 0.8,
                margin: EdgeInsets.only(bottom: Dimensions.screenHeight * 0.2),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(width: 1, color: AppColors.white)),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icons/google.svg'),
                    const SizedBox(
                      width: 20,
                    ),
                    const AppText(
                      text: "Sign-in with Google",
                      fontSize: 20,
                      fontColor: AppColors.white,
                      fontFamily: 'ProximaNova',
                    )
                  ],
                ),
              )),
        )
      ]),
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

    canvas.drawPath(redArc, Paint()..color = Colors.blue);

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
