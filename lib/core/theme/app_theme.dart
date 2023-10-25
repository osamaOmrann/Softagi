import 'package:flutter/material.dart';
import 'package:softagi/core/utils/colors.dart';
import 'package:softagi/core/utils/text_style.dart';

ThemeData getAppTheme() {
  return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.white,
      textTheme: TextTheme(
          displayLarge: boldStyle(color: AppColors.white),
          displayMedium: regularStyle()
      ),
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          hintStyle: boldStyle(color: AppColors.grey, fontSize: 16)
      ),
  );
}