import 'package:flutter/material.dart';

final _buttonTextStyle = WidgetStateProperty.resolveWith((states) {
  if (states.contains(WidgetState.disabled))
    return const TextStyle(fontSize: 20, fontFamily: "Nunito");

  return const TextStyle(fontSize: 20, fontFamily: "Nunito");
});

final _buttonForegroundColor = WidgetStateColor.resolveWith((states) {
  if (states.contains(WidgetState.disabled)) return Color(0xFFBCBCBF);
  return const Color(0xFFFFFFFF);
});

final _buttonBackgroundColor = WidgetStateColor.resolveWith((states) {
  if (states.contains(WidgetState.disabled)) return const Color(0xFFF2F2F2);
  return const Color(0xFFFF8702);
});

class AppThemeData {
  static final theme = ThemeData(
      fontFamily: "Nunito",
      scaffoldBackgroundColor: const Color(0xFFFFFDFC),
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFFFF8702),
          onPrimary: Color(0xFFFFFFFF),
          secondary: Color(0xFFFF8702),
          onSecondary: Color(0xFFFFFFFF),
          error: Color(0xFFFFFFFF),
          onError: Color(0xFFFFFFFF),
          surface: Color(0xFFFFFFFF),
          onSurface: Color(0xFFBCBCBF)),
      appBarTheme: const AppBarTheme(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Color(0xFFFFFDFC),
          titleTextStyle: TextStyle(
              color: Color(0xFFBCBCBF),
              fontWeight: FontWeight.w700,
              fontSize: 18)),
      inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(color: Color(0xFFBCBCBF), fontSize: 14),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(16.0),
          ),
          filled: true,
          fillColor: Colors.white),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              fixedSize: WidgetStateProperty.all(Size.fromHeight(44)),
              textStyle: _buttonTextStyle,
              foregroundColor: _buttonForegroundColor,
              backgroundColor: _buttonBackgroundColor)));
}
