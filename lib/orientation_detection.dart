import 'package:flutter/cupertino.dart';

class OrientationDetection {
  static late double screenWidth;
  static late double screenHeight;
  static bool isPortrait = true;
  static void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      screenHeight = constraints.maxHeight;
      screenWidth = constraints.maxWidth;
    } else {
      screenHeight = constraints.maxWidth;
      screenWidth = constraints.maxHeight;
    }
  }
}
