import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:sizer/sizer.dart';

ThemeData themeData = ThemeData(
    appBarTheme: AppBarTheme(
        foregroundColor: commonGreen,
        backgroundColor: commonWhite,
        elevation: 0,
        iconTheme: IconThemeData(size: 24.sp)),
    scaffoldBackgroundColor: commonWhite,
    iconTheme: IconThemeData(color: commonGreen, size: 28.sp),
    textTheme: TextTheme(
      labelMedium: GoogleFonts.nunito(
          fontSize: 16.sp, color: commonBlack, fontWeight: FontWeight.bold),
      labelSmall: GoogleFonts.nunito(
          fontSize: 10.sp, color: commonBlack, fontWeight: FontWeight.normal),
      labelLarge: GoogleFonts.nunito(
          fontSize: 14.sp, color: commonBlack, fontWeight: FontWeight.bold),
      displayLarge: GoogleFonts.monoton(
          color: commonGreen,
          fontSize: 30.sp,
          fontWeight: FontWeight.w500,
          shadows: [
            Shadow(
                color: commonGreen.withOpacity(0.3),
                offset: Offset(5.sp, 6.sp),
                blurRadius: 15),
          ]),
      displayMedium: GoogleFonts.monoton(
          color: commonBlack,
          fontSize: 30.sp,
          fontWeight: FontWeight.w500,
          shadows: [
            Shadow(
                color: commonBlack.withOpacity(0.3),
                offset: Offset(5.sp, 6.sp),
                blurRadius: 15),
          ]),
      displaySmall: GoogleFonts.nunito(
          fontSize: 20.sp, letterSpacing: .8.sp, height: 1.2.sp),
      headlineLarge: GoogleFonts.nunito(
          fontSize: 18.sp, fontWeight: FontWeight.w800, color: commonBlack),
      headlineSmall:
          GoogleFonts.nunito(fontSize: 18.sp, fontWeight: FontWeight.bold),
      headlineMedium: GoogleFonts.nunito(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: commonWhite,
      ),
    ));
