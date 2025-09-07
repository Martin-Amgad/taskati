import 'package:flutter/material.dart';
import 'package:taskati/core/services/local_helper.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';

class AppThheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.transparent,
      foregroundColor: AppColors.white,
      backgroundColor: AppColors.white,
      iconTheme: IconThemeData(color: AppColors.primarycolor),
    ),
    fontFamily: 'poppins',
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primarycolor,
      onSurface: AppColors.darkcolor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyles.getBody(color: AppColors.greycolor),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: AppColors.primarycolor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: AppColors.primarycolor),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkcolor,
    appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.transparent,
      foregroundColor: AppColors.primarycolor,
      backgroundColor: AppColors.darkcolor,
      titleTextStyle: TextStyles.getTitle(color: AppColors.primarycolor),
    ),
    fontFamily: 'poppins',
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primarycolor,
      onSurface: AppColors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyles.getBody(color: AppColors.greycolor),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: AppColors.primarycolor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: AppColors.primarycolor),
      ),
    ),
    datePickerTheme: DatePickerThemeData(backgroundColor: AppColors.darkcolor),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: AppColors.darkcolor,
      dialBackgroundColor: AppColors.darkcolor,
      hourMinuteColor: AppColors.darkcolor,
      hourMinuteTextColor: AppColors.white,
    ),
  );
}
