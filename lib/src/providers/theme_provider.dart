import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _selectedTheme = ThemeData.light();

  ThemeData light = ThemeData.light().copyWith(
    primaryColor: const Color.fromRGBO(238, 89, 33, 1),
    hoverColor: const Color.fromRGBO(238, 89, 33, 1),
    secondaryHeaderColor: const Color.fromRGBO(238, 89, 33, 1),
    scaffoldBackgroundColor: const Color.fromRGBO(255, 251, 250, 1),
    backgroundColor: const Color.fromRGBO(250, 239, 235, 1),
    canvasColor: const Color.fromRGBO(232, 196, 183, 1),
    appBarTheme: const AppBarTheme(color: Colors.white),
    focusColor: Colors.white24,
    errorColor: Colors.white,
    highlightColor: const Color.fromRGBO(49, 52, 56, 1),
    cardTheme: CardTheme(
      color: Colors.grey[300],
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headline2: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      headline3: TextStyle(
        color: Color.fromRGBO(32, 33, 40, 1),
        fontSize: 15,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.lineThrough,
      ),
      headline4: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: Colors.white,
      ),
      headline5: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: Colors.black,
      ),
      headline6: TextStyle(
        color: Colors.grey,
        fontSize: 15,
      ),
      subtitle1: TextStyle(
        color: Colors.black,
        fontSize: 17,
      ),
      subtitle2: TextStyle(
        color: Colors.black,
        fontSize: 15,
      ),
    ),
  );

  ThemeProvider() {
    _selectedTheme = light;
  }

  ThemeData getTheme() => _selectedTheme;
}
