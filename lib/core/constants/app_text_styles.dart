import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get displayLarge => GoogleFonts.poppins(
        fontSize: 36.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.textDark,
        height: 1.2,
      );

  static TextStyle get displayMedium => GoogleFonts.poppins(
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textDark,
        height: 1.3,
      );

  static TextStyle get h1 => GoogleFonts.poppins(
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textDark,
      );

  static TextStyle get h2 => GoogleFonts.poppins(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      );

  static TextStyle get h3 => GoogleFonts.poppins(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      );

  static TextStyle get bodyLarge => GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textMedium,
        height: 1.6,
      );

  static TextStyle get bodyMedium => GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textMedium,
        height: 1.5,
      );

  static TextStyle get bodySmall => GoogleFonts.poppins(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textLight,
        height: 1.4,
      );

  static TextStyle get noteTitle => GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );

  static TextStyle get noteBody => GoogleFonts.poppins(
        fontSize: 11.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white70,
        height: 1.4,
      );

  static TextStyle get noteDate => GoogleFonts.poppins(
        fontSize: 9.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white54,
      );

  static TextStyle get label => GoogleFonts.poppins(
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textMedium,
      );

  static TextStyle get button => GoogleFonts.poppins(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 0.3,
      );

  static TextStyle get caption => GoogleFonts.poppins(
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textLight,
        letterSpacing: 0.2,
      );

  static TextStyle get inputTitle => GoogleFonts.poppins(
        fontSize: 26.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      );

  static TextStyle get inputBody => GoogleFonts.poppins(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textMedium,
        height: 1.6,
      );

  static TextStyle get inputHint => GoogleFonts.poppins(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textHint,
      );
}
