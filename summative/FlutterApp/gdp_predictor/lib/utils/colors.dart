import 'package:flutter/material.dart';

class AppColors {
  // Blue-grey as primary
  static const Color primary = Color(0xFF5D89BA); // Cool blue-grey
  static const Color secondary = Color(0xFF14632F); // Keeping your forest green
  static const Color background = Color(0xFFFAFAFA);
  static const Color text = Color(0xFF040404);

  // Blue-grey based swatch for primary color
  static const Map<int, Color> primarySwatch = {
    50: Color(0xFFF0F4F8), // Lightest blue-grey
    100: Color(0xFFD9E4ED),
    200: Color(0xFFB3CAE0),
    300: Color(0xFF8DAFD2),
    400: Color(0xFF739BC6),
    500: Color(0xFF5D89BA), // Primary blue-grey
    600: Color(0xFF507BA8),
    700: Color(0xFF436A91),
    800: Color(0xFF375979),
    900: Color(0xFF284054), // Darkest blue-grey
  };
}
