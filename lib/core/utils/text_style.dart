import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:softagi/core/utils/colors.dart';

TextStyle _textStyle(
    {required Color color,
    required double fontSize,
    required FontWeight fontWeight}) {
  return GoogleFonts.lato(
      color: color, fontSize: fontSize, fontWeight: fontWeight);
}

TextStyle boldStyle(
        {Color color = AppColors.black,
        double fontSize = 24}) =>
    _textStyle(color: color, fontSize: fontSize, fontWeight: FontWeight.bold);

TextStyle regularStyle(
    {Color color = AppColors.black,
      double fontSize = 24}) =>
    _textStyle(color: color, fontSize: fontSize, fontWeight: FontWeight.normal);
