import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyleText {
  static styleSourceSansPro({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    String? locale,
    double? height,
  }) {
    return GoogleFonts.sourceSansPro(
      fontStyle: fontStyle ?? FontStyle.normal,
      locale: Locale(locale ?? 'ID'),
      fontSize: fontSize ?? 12,
      color: color ?? Colors.black,
      fontWeight: fontWeight ?? FontWeight.normal,
      height: height ?? 1.0,
    );
  }

  static styleMontserrat({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    String? locale,
    double? height,
  }) {
    return GoogleFonts.montserrat(
      fontStyle: fontStyle ?? FontStyle.normal,
      locale: Locale(locale ?? 'ID'),
      fontSize: fontSize ?? 12,
      color: color ?? Colors.black,
      fontWeight: fontWeight ?? FontWeight.normal,
      height: height ?? 1.0,
    );
  }
}
