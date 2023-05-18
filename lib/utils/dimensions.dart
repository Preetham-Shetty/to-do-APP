import 'package:flutter/material.dart';

class Dimensions {
  static void init({
    required context,
  }) {
    _queryData = MediaQuery.of(context);
    screenHeight = _queryData.size.height;
    screenWidth = _queryData.size.width;
  }

  static late MediaQueryData _queryData;
  static late double screenHeight;
  static late double screenWidth;
}
