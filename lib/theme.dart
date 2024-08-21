import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Color(0xFFF7F7F7),
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      brightness: Brightness.light,
      primaryColor: const Color(0xFFF7F7F7),
      scaffoldBackgroundColor: const Color(0xFFF7F7F7),
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Color(0xFF08100C),
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF08100C),
      scaffoldBackgroundColor: const Color(0xFF08100C),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }
}
