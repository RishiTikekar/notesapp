import 'package:flutter/material.dart';

class MyThemeData {
  static const Color PRIMARY_BLACK_COLOR = Color(0xFF070706);
  static const Color ORANGE_NOTES = Color(0xFFfe9a37);
  static const Color GREEN_NOTES = Color(0xFFcbdb57);
  static const Color PURPLE_NOTES = Color(0XFF9585ba);
  static const Color GREY_NOTES = Color(0XFF5c4f45);
  static const Color PEACH_NOTES = Color(0XFFf96a4b);
  static const Color BROWN_NOTES = Color(0XFFdea44d);
  static const Color DARK_BROWN_NOTES = Color(0xFF9e5c32);

  static ThemeData notesThemeData = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: PRIMARY_BLACK_COLOR,
    accentColor: PRIMARY_BLACK_COLOR,
    scaffoldBackgroundColor: PRIMARY_BLACK_COLOR,
    fontFamily: 'Nunito',
    textTheme: TextTheme(
      headline1: TextStyle(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800),
      headline2: TextStyle(
          color: PRIMARY_BLACK_COLOR,
          fontSize: 23,
          fontWeight: FontWeight.w700),
      bodyText1: TextStyle(
          color: Colors.white, fontSize: 32, fontWeight: FontWeight.w800),
      subtitle1: TextStyle(
          color: GREEN_NOTES, fontSize: 24, fontWeight: FontWeight.w500),
      subtitle2: TextStyle(
          color: PRIMARY_BLACK_COLOR,
          fontSize: 22,
          fontWeight: FontWeight.w600),
      caption: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w200),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white24),
        fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(15)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ),
  );
}
