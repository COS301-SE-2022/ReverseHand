import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get darkTheme { 
    return ThemeData( 
      primaryColor: const Color.fromRGBO(243, 157, 55, 1),
      scaffoldBackgroundColor: const Color.fromRGBO(18, 26, 34, 1), //background colour
      textTheme: ThemeData.dark().textTheme,
      fontFamily: 'Segoe UI',
    );
  }
}