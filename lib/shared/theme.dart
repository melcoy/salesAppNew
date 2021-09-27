import 'package:flutter/material.dart';

const BorderRadius defaultRadius = BorderRadius.all(Radius.circular(8));
const BorderRadius circularRadius = BorderRadius.all(Radius.circular(500));
const Radius defaultRadiusValue = Radius.circular(8);
const Color primaryColor = Color(0xffEB5757);
const Color accentColor = Color(0xffFD9898);
ThemeData theme = ThemeData(
  fontFamily: "Nunito",
  primaryColor: primaryColor,
  appBarTheme: const AppBarTheme(elevation: 0, backgroundColor: primaryColor),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: accentColor),
);
