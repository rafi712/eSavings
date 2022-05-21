import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color greenColor = const Color(0xff0EC3AE);
Color redColor = const Color(0xffEB70A5);
Color blackColor = const Color(0xff1F1449);
Color greyColor = const Color(0xff9698A9);
Color blueColor = const Color(0xFF6FB7DD);

TextStyle blackTextStyle = GoogleFonts.poppins(color: blackColor);
TextStyle whiteTextStyle = GoogleFonts.poppins(color: Colors.white);
TextStyle redTextStyle = GoogleFonts.poppins(color: redColor);
TextStyle greenTextStyle = GoogleFonts.poppins(color: greenColor);
TextStyle greyTextStyle = GoogleFonts.poppins(color: greyColor);
TextStyle blueTextStyle = GoogleFonts.poppins(color: blueColor);

BoxShadow defaultShadow = BoxShadow(
  color: const Color(0xff191410).withOpacity(0.05),
  blurRadius: 40,
  offset: const Offset(0, 10),
);
BoxShadow blueShadow = BoxShadow(
  color: blueColor.withOpacity(0.09),
  blurRadius: 40,
  offset: const Offset(0, 10),
);
BoxShadow redShadow = BoxShadow(
  color: redColor.withOpacity(0.2),
  blurRadius: 40,
  offset: const Offset(0, 10),
);
BoxShadow greenShadow = BoxShadow(
  color: greenColor.withOpacity(0.09),
  blurRadius: 40,
  offset: const Offset(0, 10),
);

