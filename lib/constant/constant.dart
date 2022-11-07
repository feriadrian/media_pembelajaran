import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_projeck/config/config.dart';

// For App Color
const Color kPrimaryColor = Color(0xFF7367F0);
const Color kPrimaryLightColor = Color(0xFF978EF3);
const Color kBackgroundColor2 = Color(0xFFFFFFFF);
const Color kAlert = Color(0xFFED6363);

//For Text Color
const Color kPrimaryTextColor = Color(0xFF565656);
const Color kSubtitleTextColor = Color(0xFFA1A1A1);

// Costum text style
TextStyle primaryTextStyle = GoogleFonts.redHatDisplay(
  color: kPrimaryTextColor,
);

TextStyle primaryLightTextStyle = GoogleFonts.redHatDisplay(
  color: kPrimaryLightColor,
);

TextStyle subtitleTextStyle = GoogleFonts.redHatDisplay(
  color: kSubtitleTextColor,
);

TextStyle whiteTextStyle = GoogleFonts.redHatDisplay(
  color: kBackgroundColor2,
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;

// padding
double defaultPadding = getPropertionateScreenWidht(24);

// Additional Config
const Color cardGreenColor1 = Color(0xFFADF9CF);
