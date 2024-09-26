import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expense_tracker/themes/color_schemes.dart';

var darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: GoogleFonts.lato().fontFamily,
).copyWith(
  colorScheme: kDarkColorScheme,
  
  cardTheme: const CardTheme().copyWith(
    color: kDarkColorScheme.secondaryContainer,
    margin: const EdgeInsets.all(10),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kDarkColorScheme.primaryContainer,
    ),
  ),
);
