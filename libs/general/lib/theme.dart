import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomerTheme {
  static ThemeData get darkTheme { 
    return ThemeData( 
      primaryColor: Color.fromRGBO(243, 157, 55, 1),
      //secondaryColor: Color.fromRGBO(35, 47, 62, 1),
      scaffoldBackgroundColor: Color.fromRGBO(18, 26, 34, 1), //background colour
      textTheme: ThemeData.dark().textTheme,
    );
  }
}