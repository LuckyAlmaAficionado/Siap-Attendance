import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:hexcolor/hexcolor.dart";

// .. Light
Color lightGreyColor = Colors.grey.shade50;
Color lightBlueColor = HexColor("53C1F9");

// .. Dark
Color darkGreyColor = Colors.grey;
// Color darkBlueColor = Colors.blue.shade900;
Color darkBlueColor = HexColor("191D88");
Color darkRedColor = HexColor("E74C3C");

// .. Normal
Color redColor = Colors.red;
Color blueColor = HexColor("3085FE");
Color whiteColor = Colors.white;
Color blackColor = Colors.black;
Color greenColor = Colors.green;
Color greenColor1 = HexColor("91C789");

// TextStyle normalTextStyle = GoogleFonts.nunito(color: Colors.black);

TextStyle blackTextStyle = GoogleFonts.nunito(color: Colors.black);

TextStyle greenTextStyle = GoogleFonts.nunito(color: greenColor);

TextStyle whiteTextStyle = GoogleFonts.nunito(color: Colors.white);

TextStyle lightGreyTextStyle = GoogleFonts.nunito(color: lightGreyColor);

TextStyle darkGreyTextStyle = GoogleFonts.nunito(color: darkGreyColor);

TextStyle lightBlueTextStyle = GoogleFonts.nunito(color: lightBlueColor);

TextStyle blueTextStyle = GoogleFonts.nunito(color: Colors.blue[800]);

TextStyle redTextStyle = GoogleFonts.nunito(color: Colors.red);

TextStyle normalTextStyle = GoogleFonts.plusJakartaSans(
  color: blackColor,
  fontSize: 14,
);

// ... TEXTSTYLE APPBAR
TextStyle appBarTextStyle = normalTextStyle.copyWith(
  fontWeight: semiBold,
  color: whiteColor,
  fontSize: 16,
);

// .. FONTWEIGHT
FontWeight extraLight = FontWeight.w100;
FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;
