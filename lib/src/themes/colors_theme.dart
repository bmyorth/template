import 'package:flutter/material.dart';

class AppColors {
  //app
  static const primary = Color(0xFF1D2228);
  static const secondary = Color(0xFFB5BAC0);
  static const accent = Color(0xFFCFE5FF);
  static const white = Color.fromRGBO(255, 255, 255, 1.0);
  static const loadingBgColor = Color(0xFF1B1B1B);
  static const backgroundApp = white;

  //input
  static const backgroundInput = accent;
  static final errorColor = Colors.red[300];
  static final successColor = Colors.green[300];
  static const focusInput = primary;

  //textos
  static const textColorPrimary = primary;
  static const textColorDark = Color.fromRGBO(17, 17, 25, 1.0);
  static const textColorHint = Colors.black54;
  static const textGreySmall = Color.fromRGBO(70, 70, 70, 1.0);
  static const textGreySmallInactive = Color.fromRGBO(70, 70, 70, 0.5);
}
