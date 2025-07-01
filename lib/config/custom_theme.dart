import 'package:flutter/material.dart';

class CustomTheme {
  static TextTheme textTheme(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return TextTheme(
      bodyLarge: TextStyle(
        fontSize: width * 0.049,
        fontWeight: FontWeight.bold,
        color: bodyLargeColor,
        fontFamily: 'Poppins',
      ),
      bodyMedium: TextStyle(
        fontSize: width * 0.040,
        fontWeight: FontWeight.bold,
        color: bodyMediumColor,
      ),
      bodySmall: TextStyle(
        fontSize: width * 0.030,
        fontWeight: FontWeight.w600,
        color: bodySmallColor,
        fontFamily: '',
      ),
    );
  }

  static const Color backgroundColor = Color.fromARGB(255, 242, 242, 242);
  static const Color secondaryColor = Colors.white;
  static const Color primaryColor = Color.fromARGB(255, 37, 211, 102);
  static const Color accentColor = Color.fromARGB(255, 219, 219, 219);

  static const Color bodyMediumColor = Colors.black;
  static const Color bodyLargeColor = Colors.black;
  static const Color bodySmallColor = Colors.black;

  static ThemeData themeData(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Color.fromARGB(255, 242, 242, 242),
      textTheme: textTheme(context),
    );
  }
}
