import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xfffc9f12),
      onPrimary: Color(0xffffffff),
      secondary: Color(0xffa5957d),
      secondaryFixed: Color(0xff737373), // Optional, may not be used in default ColorScheme
      onSecondary: Color(0xffffffff),
      tertiary: Color(0xffd97805),
      error: Color(0xffe50a13),
      onError: Color(0xffffffff),
      surface: Color(0xff000000),
      onSurface: Color(0xffffffff),
      shadow: Color(0xff2b2b2b),
      scrim: Color(0xffe9a135), // Adjust as needed
    )
);
