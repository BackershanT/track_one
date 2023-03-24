import 'package:flutter/material.dart';
import 'package:track_one/src/app_colors/app_color.dart';

class AppTheme {
  static final colors = AppColor();
  static ThemeData define() {
    return ThemeData(
      primaryColor: const Color(0XFFFFFFFF),
      focusColor: const Color(0XFFFFFFFF),
      scaffoldBackgroundColor: const Color(0XFFFFFFFF),
    );
  }
}
