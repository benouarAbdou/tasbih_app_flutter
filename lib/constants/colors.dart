import 'package:flutter/material.dart';

class MyColors {
  static const Color primaryColor = Color(0xFF12A18F);
  static const Color lightPrimaryColor = Color(0xFF14C1AB);
  static const Color secondaryColor = Color(0xFFFEC12A);

  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static const Color greyColor = Color(0xFFF3F3F3);

  static const MaterialColor primaryMaterialColor = MaterialColor(
    0xFF12A18F,
    <int, Color>{
      50: Color(0xFFE0F2E9), // 10%
      100: Color(0xFFB2E1D5), // 20%
      200: Color(0xFF80D3B2), // 30%
      300: Color(0xFF4FBF8F), // 40%
      400: Color(0xFF26B877), // 50%
      500: Color(0xFF12A18F), // 60% (primary color)
      600: Color(0xFF0E8C7A), // 70%
      700: Color(0xFF0B746E), // 80%
      800: Color(0xFF09605C), // 90%
      900: Color(0xFF05403D), // 100%
    },
  );
}
