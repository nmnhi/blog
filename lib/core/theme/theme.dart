import 'package:blog_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = AppPalette.borderColor]) => OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: color),
      borderRadius: BorderRadius.circular(10));

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPalette.backgroundColor,
    appBarTheme: const AppBarTheme(backgroundColor: AppPalette.backgroundColor),
    chipTheme: const ChipThemeData(
      side: BorderSide.none,
      color: WidgetStatePropertyAll(AppPalette.backgroundColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(16),
        border: _border(),
        enabledBorder: _border(),
        focusedBorder: _border(AppPalette.gradient2),
        errorBorder: _border(AppPalette.errorColor)),
  );
}
