import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? fontColor;
  final TextOverflow? overflow;
  final int? maxline;
  final FontWeight? fontWeight;
  final TextAlign? fontAlign;
  final String? fontFamily;

  const AppText(
      {required this.text,
      this.fontColor,
      required this.fontSize,
      this.overflow,
      this.fontWeight,
      this.fontAlign,
      this.maxline,
      this.fontFamily,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      textAlign: fontAlign,
      maxLines: maxline,
      style: TextStyle(
          fontSize: fontSize.sp,
          color: fontColor,
          fontWeight: fontWeight,
          fontFamily: fontFamily),
    );
  }
}
