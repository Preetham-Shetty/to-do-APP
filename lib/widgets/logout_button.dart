import 'package:flutter/material.dart';
import 'package:todoapp/services/googlesignin.dart';
import 'package:todoapp/utils/colors.dart';
import 'package:todoapp/utils/dimensions.dart';
import 'package:todoapp/utils/text.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoogleSigninProvider().googleLogOut();
      },
      child: Container(
        width: Dimensions.screenWidth * 0.7,
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.screenHeight * 0.02,
            vertical: Dimensions.screenHeight * 0.01),
        margin: EdgeInsets.only(bottom: Dimensions.screenHeight * 0.02),
        decoration: const BoxDecoration(
            color: AppColors.themeColor,
            boxShadow: [
              BoxShadow(
                  offset: Offset(3, 4),
                  color: AppColors.tabOnehadow,
                  blurRadius: 5.0)
            ],
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: const AppText(
          text: "Logout",
          fontSize: 15,
          fontAlign: TextAlign.center,
          fontColor: AppColors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'ProximaNova',
        ),
      ),
    );
  }
}
