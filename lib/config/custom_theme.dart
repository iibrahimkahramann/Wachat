import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.accentColor,
    required this.secondaryColor,
  });

  final Color accentColor;
  final Color secondaryColor;

  @override
  AppColors copyWith({Color? accentColor, Color? secondaryColor}) {
    return AppColors(
      accentColor: accentColor ?? this.accentColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      accentColor: Color.lerp(accentColor, other.accentColor, t)!,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
    );
  }
}

class CustomTheme {
  static TextTheme _textTheme(BuildContext context, Color bodyLargeColor,
      Color bodyMediumColor, Color bodySmallColor) {
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

  static ThemeData lightTheme(BuildContext context) {
    const primaryColor = Color.fromARGB(255, 37, 211, 102);
    const bodyColor = Colors.black;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: const Color.fromARGB(255, 242, 242, 242),
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: Colors.white,
        surface: Colors.white,
        onSurface: bodyColor,
        background: Color.fromARGB(255, 242, 242, 242),
        onBackground: bodyColor,
        error: Colors.red,
        onError: Colors.white,
        brightness: Brightness.light,
        onPrimary: Colors.white,
        onSecondary: bodyColor,
      ),
      textTheme: _textTheme(context, bodyColor, bodyColor, bodyColor),
      extensions: <ThemeExtension<dynamic>>[
        const AppColors(
          accentColor: Color.fromARGB(255, 219, 219, 219),
          secondaryColor: Colors.white,
        ),
      ],
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    const primaryColor = Color.fromARGB(255, 37, 211, 102);
    const bodyColor = Colors.white;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.black,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: Color.fromARGB(255, 30, 30, 30),
        surface: Color.fromARGB(255, 30, 30, 30),
        onSurface: bodyColor,
        background: Colors.black,
        onBackground: bodyColor,
        error: Colors.red,
        onError: Colors.white,
        brightness: Brightness.dark,
        onPrimary: Colors.white,
        onSecondary: bodyColor,
      ),
      textTheme: _textTheme(context, bodyColor, bodyColor, bodyColor),
      extensions: <ThemeExtension<dynamic>>[
        const AppColors(
          accentColor: Color.fromARGB(255, 50, 50, 50),
          secondaryColor: Color.fromARGB(255, 30, 30, 30),
        ),
      ],
    );
  }
}