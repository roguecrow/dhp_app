import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff00b466)),
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: Colors.black, // Set body text color to white
    displayColor: Colors.black, // Set headline text color to white
  ),
  primaryColor: const Color(0xff00b466),
);


ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff00b466) , brightness: Brightness.dark),
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: Colors.white, // Set body text color to white
    displayColor: Colors.white, // Set headline text color to white
  ),
  primaryColor: const Color(0xcf08371a),
);
