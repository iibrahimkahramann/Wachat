import 'package:flutter/material.dart';

class CustomTheme {
  static TextTheme textTheme(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return TextTheme(
      bodyLarge: TextStyle(
        fontSize: width * 0.049,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: 'Poppins',
      ),
      bodyMedium: TextStyle(
        fontSize: width * 0.040,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        fontSize: width * 0.030,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontFamily: '',
      ),
    );
  }

  static ThemeData themeData(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color.fromARGB(255, 242, 242, 242),
      textTheme: textTheme(context),
    );
  }
}
