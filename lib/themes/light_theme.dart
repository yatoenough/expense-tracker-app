import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expense_tracker/themes/color_schemes.dart';

var lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: GoogleFonts.lato().fontFamily,
).copyWith(
  colorScheme: kColorScheme,
  cardTheme: const CardTheme().copyWith(
    color: kColorScheme.secondaryContainer,
    margin: const EdgeInsets.all(10),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kColorScheme.primaryContainer,
    ),
  ),
);
