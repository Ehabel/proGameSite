import 'dart:ui';
import 'package:flutter/material.dart';

import 'dimensions.dart';

class AppConstants{
  static const String name = "Game Pop";
  static const String fontMain = "Roboto";
  static const String fontSecondary = "RobotoMono";
  static const String fontLogo = "Roboto";
  static const FontWeight fontWeightLogo = FontWeight.w500;
  static const FontWeight fontWeightHeading = FontWeight.w700;
  static ImageFilter backDropFilter = ImageFilter.blur(sigmaX: 1, sigmaY: 1);
  static BoxShadow shadow = BoxShadow(color: Colors.grey.withOpacity(0.08), spreadRadius: Dimensions.height1/4, blurRadius: Dimensions.height15, offset: const Offset(0, 0));
  static const Color backgroundColor = Color(0xFFB9D397);
  static const Color menuTextColor = Colors.black;
  static const Color splashColor = Colors.white;
  static const double topBarOpacity = .4;
  static const double viewPortFractionGameSlider = 0.5;
  static const double scrollBarOpacity = .45;
  static const int topBarDuration = 120;
  static const int signUpDuration = 300;
  static const int buttonIconDuration = 300;
  static const double maxWidth = 700;
  static const Color hoverColor = Colors.white10;
  static const Color headerColor = Colors.black;
  static const int rating = 5;
  static const String loremIpsum = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit,
sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
  
Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut
aliquip ex ea commodo consequat.
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum
dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,
sunt in culpa qui officia deserunt mollit anim id est laborum.
  
Lorem ipsum dolor sit amet, consectetur adipiscing elit.
""";
}