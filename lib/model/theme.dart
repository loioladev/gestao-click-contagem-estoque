import 'package:flutter/material.dart';

class ThemeOfProject {
  ThemeData themeData = ThemeData(
      appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF005073),
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
          )),
      primaryColor: Colors.blue,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blue),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
        filled: true,
        fillColor: Color(0xFF107dac),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFAB2037))),
        errorStyle: TextStyle(color: Color(0xFF7C2037)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF058565))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF07B88C))),
        border: OutlineInputBorder(),
        hoverColor: Colors.white,
      ),
      hintColor: Colors.white,
      textTheme: const TextTheme(
        subtitle1: TextStyle(color: Colors.white),
      ),
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: Colors.white));
}
