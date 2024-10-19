import 'package:flutter/material.dart';


// Screen Configuration to scale display with regards to device screen sice
class SizeUtilKt {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
  }
}

double getProportionateScreenHeight(double inputHeight) {
  var screenHeight = SizeUtilKt.screenHeight;
  return (inputHeight / 1728.0) * screenHeight!;
}

double getTextScaleFactor(){
  return SizeUtilKt.screenWidth! / 1117;
}

double getProportionateScreenWidth(double inputWidth) {
  var screenWidth = SizeUtilKt.screenWidth;
  return (inputWidth / 1117.0) * screenWidth!;
}
