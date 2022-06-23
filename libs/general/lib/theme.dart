import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: const Color.fromRGBO(243, 157, 55, 1),
      scaffoldBackgroundColor:
          const Color.fromRGBO(18, 26, 34, 1), //background colour
      primaryColorDark: const Color.fromRGBO(35, 47, 62, 1), //primary blue used
      primaryColorLight: const Color.fromRGBO(68, 82, 98, 1),
      textTheme: ThemeData.dark().textTheme,
      fontFamily: 'Segoe UI',
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
    );
  }
}
