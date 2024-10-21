import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sizer/sizer.dart';
import 'colors.dart';
import 'fonts.dart';

class AppTextStyle {
  static TextStyle normal10(Color color) {
    return TextStyle(
      color: color,
      fontFamily: AppFonts.graphikRegular,
      fontSize: 10.0.sp,
    );
  }

  static TextStyle statusStyle(Color color) {
    return TextStyle(
      color: color,
      fontFamily: AppFonts.graphikSemibold,
      fontSize: 10.0.sp,
    );
  }
  ///////////////////////
  /// Normal grey Style
  //////////////////////
  ///

  static TextStyle normalGrey8 = TextStyle(
    color: AppColors.greyColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 8.0.sp,
  );

  static TextStyle semiBoldRed12 = TextStyle(
    color: AppColors.redColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 12.0.sp,
  );
  static TextStyle normalGrey9 = TextStyle(
    color: AppColors.greyColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 9.0.sp,
  );
  static TextStyle normalGrey10 = TextStyle(
    color: AppColors.greyColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 10.0.sp,
  );
  static TextStyle normalGrey11 = TextStyle(
    color: AppColors.greyColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 11.0.sp,
  );
  static TextStyle normalGrey12 = TextStyle(
    color: AppColors.greyColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 12.0.sp,
  );

  static var normalGrey12Communication = Style(
    color: AppColors.greyColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: FontSize(12.0.sp),
  );
  static TextStyle normalGrey13 = TextStyle(
    color: AppColors.greyColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 13.0.sp,
  );
  static TextStyle normalGrey14 = TextStyle(
    color: AppColors.greyColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 14.0.sp,
  );
  static TextStyle normalGrey15 = TextStyle(
    color: AppColors.greyColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 15.0.sp,
  );
  static TextStyle normalGrey16 = TextStyle(
    color: AppColors.greyColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 16.0.sp,
  );
  ///////////////////////
  /// semiBold grey Style
  //////////////////////

  static TextStyle semiBoldGrey8 = TextStyle(
    color: AppColors.greyColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 8.0.sp,
  );
  static TextStyle semiBoldGrey9 = TextStyle(
    color: AppColors.greyColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 9.0.sp,
  );
  static TextStyle semiBoldGrey10 = TextStyle(
    color: AppColors.greyColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 10.0.sp,
  );
  static TextStyle semiBoldGrey11 = TextStyle(
    color: AppColors.greyColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 11.0.sp,
  );
  static TextStyle semiBoldGrey12 = TextStyle(
    color: AppColors.greyColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 12.0.sp,
  );
  static TextStyle semiBoldGrey13 = TextStyle(
    color: AppColors.greyColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 13.0.sp,
  );
  static TextStyle semiBoldGrey14 = TextStyle(
    color: AppColors.greyColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 14.0.sp,
  );
  static TextStyle semiBoldGrey15 = TextStyle(
    color: AppColors.greyColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 15.0.sp,
  );
  static TextStyle semiBoldGrey16 = TextStyle(
    color: AppColors.greyColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 16.0.sp,
  );

  ///////////////////////
  /// Normal Black Style
  //////////////////////

  static TextStyle normalBlack8 = TextStyle(
    color: AppColors.blackColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 8.0.sp,
  );
  static TextStyle normalBlack9 = TextStyle(
    color: AppColors.blackColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 9.0.sp,
  );
  static TextStyle normalBlack10 = TextStyle(
    color: Colors.black,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 10.0.sp,
  );

  static TextStyle normalBlack11 = TextStyle(
    color: AppColors.blackColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 11.0.sp,
  );
  static TextStyle normalBlack12 = TextStyle(
    color: AppColors.blackColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 12.0.sp,
  );
  static TextStyle normalBlack13 = TextStyle(
    color: AppColors.blackColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 13.0.sp,
  );
  static TextStyle normalBlack14 = TextStyle(
    color: AppColors.blackColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 14.0.sp,
  );
  static TextStyle normalBlack15 = TextStyle(
    color: AppColors.blackColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 15.0.sp,
  );
  static TextStyle normalBlack16 = TextStyle(
    color: AppColors.blackColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 16.0.sp,
  );
  ///////////////////////
  /// semiBold Black Style
  //////////////////////

  static TextStyle semiBoldBlack8 = TextStyle(
    color: AppColors.blackColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 8.0.sp,
  );
  static TextStyle semiBoldBlack9 = TextStyle(
    color: AppColors.blackColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 9.0.sp,
  );

  static TextStyle semiBoldBlack10 = TextStyle(
    color: AppColors.blackColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 10.0.sp,
  );

  static TextStyle semiBoldBlack11 = TextStyle(
    color: AppColors.blackColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 11.0.sp,
  );
  static TextStyle semiBoldBlack12 = TextStyle(
    color: AppColors.blackColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 12.0.sp,
  );
  static TextStyle semiBoldBlack13 = TextStyle(
    color: AppColors.blackColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 13.0.sp,
  );
  static TextStyle semiBoldBlack14 = TextStyle(
    color: Colors.black,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 14.0.sp,
  );
  static TextStyle semiBoldBlack15 = TextStyle(
    color: AppColors.blackColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 15.0.sp,
  );
  static TextStyle semiBoldBlack16 = TextStyle(
    color: AppColors.blackColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 16.0.sp,
  );
  ///////////////////////
  /// Normal White Style
  //////////////////////

  static TextStyle normalWhite8 = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 8.0.sp,
  );
  static TextStyle normalWhite9 = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 9.0.sp,
  );
  static TextStyle normalWhiteul10 = TextStyle(
      color: AppColors.whiteColor,
      fontFamily: AppFonts.graphikRegular,
      fontSize: 10.0.sp,
      decoration: TextDecoration.underline);
  static TextStyle normalWhite10 = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 10.0.sp,
  );

  static TextStyle normalWhite11 = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 11.0.sp,
  );
  static TextStyle normalWhite12 = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 12.0.sp,
  );
  static TextStyle normalWhite13 = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 13.0.sp,
  );
  static TextStyle normalWhite14 = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 14.0.sp,
  );
  static TextStyle normalWhite15 = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 15.0.sp,
  );
  static TextStyle normalWhite16 = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 16.0.sp,
  );
  ///////////////////////
  /// semiBold White Style
  //////////////////////

  static TextStyle semiBoldWhite8 = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 8.0.sp,
  );
  static TextStyle semiBoldWhite9 = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 9.0.sp,
  );
  static TextStyle semiBoldWhite10 = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 10.0.sp,
  );

  static TextStyle semiBoldWhite11 = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 11.0.sp,
  );
  static TextStyle semiBoldWhite12 = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 12.0.sp,
  );

  static TextStyle semiBoldWhite13 = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 13.0.sp,
  );
  static TextStyle semiBoldWhite14 = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 14.0.sp,
  );
  static TextStyle semiBoldWhite15 = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 15.0.sp,
  );
  static TextStyle semiBoldWhite16 = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 16.0.sp,
  );

  ///////////////////////
  /// Normal Blue Style
  //////////////////////

  static TextStyle normalBlue8 = TextStyle(
    color: AppColors.blueColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 8.0.sp,
  );
  static TextStyle normalBlue9 = TextStyle(
    color: AppColors.blueColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 9.0.sp,
  );
  static TextStyle normalBlue10 = TextStyle(
    color: AppColors.blueColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 10.0.sp,
  );

  static TextStyle normalBlue11 = TextStyle(
    color: AppColors.blueColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 11.0.sp,
  );
  static TextStyle normalBlue12 = TextStyle(
    color: AppColors.blueColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 12.0.sp,
  );
  static TextStyle normalBlue13 = TextStyle(
    color: AppColors.blueColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 13.0.sp,
  );
  static TextStyle normalBlue14 = TextStyle(
    color: AppColors.blueColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 14.0.sp,
  );
  static TextStyle normalBlue15 = TextStyle(
    color: AppColors.blueColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 15.0.sp,
  );
  static TextStyle normalBlue16 = TextStyle(
    color: AppColors.blueColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 16.0.sp,
  );
  ///////////////////////
  /// semiBold Blue Style
  //////////////////////

  static TextStyle semiBoldBlue8 = TextStyle(
    color: AppColors.blueColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 8.0.sp,
  );
  static TextStyle semiBoldBlue9 = TextStyle(
    color: AppColors.blueColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 9.0.sp,
  );
  static TextStyle semiBoldBlue10 = TextStyle(
    color: AppColors.blueColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 10.0.sp,
  );

  static TextStyle semiBoldBlue11 = TextStyle(
    color: AppColors.blueColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 11.0.sp,
  );

  static TextStyle semiBoldBlue11ul = TextStyle(
      color: AppColors.blueColor,
      fontFamily: AppFonts.graphikSemibold,
      fontSize: 11.0.sp,
      decoration: TextDecoration.underline);
  static TextStyle semiBoldBlue9ul = TextStyle(
      color: AppColors.blueColor,
      fontFamily: AppFonts.graphikSemibold,
      fontSize: 9.0.sp,
      decoration: TextDecoration.underline);
  static TextStyle semiBoldBlue12 = TextStyle(
    color: AppColors.blueColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 12.0.sp,
  );
  static TextStyle semiBoldBlue13 = TextStyle(
    color: AppColors.blueColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 13.0.sp,
  );
  static TextStyle semiBoldBlue14 = TextStyle(
    color: AppColors.blueColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 14.0.sp,
  );
  static TextStyle semiBoldBlue15 = TextStyle(
    color: AppColors.blueColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 15.0.sp,
  );
  static TextStyle semiBoldBlue16 = TextStyle(
    color: AppColors.blueColor,
    fontFamily: AppFonts.graphikSemibold,
    fontSize: 16.0.sp,
  );

  ///////////////////////
  /// Error Messages Style
  //////////////////////

  static TextStyle normalErrorText1 = TextStyle(
    color: AppColors.redColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 8.0.sp,
  );
  static TextStyle normalErrorText2 = TextStyle(
    color: AppColors.redColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 9.0.sp,
  );
  static TextStyle normalErrorText3 = TextStyle(
    color: AppColors.redColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 10.0.sp,
  );

  // Button Style

  static TextStyle buttonTextStyle = TextStyle(
    color: AppColors.blackColor,
    fontFamily: AppFonts.graphikRegular,
    fontSize: 14.0.sp,
  );

  ////////////////
  ///new styles
  ////////////////
  /// Merriweather
  static TextStyle merriweatherBoldWhite12 = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.merriweatherBold,
    fontSize: 12.0.sp,
  );
  static TextStyle merriweatherLightWhite12 = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.merriweatherLight,
    fontSize: 12.0.sp,
  );
  static TextStyle merriweatherRegularWhite12 = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.merriweatherRegular,
    fontSize: 12.0.sp,
  );

  /// Open_Sans
  static TextStyle openSansBoldWhite12 = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.openSansBold,
    fontSize: 12.0.sp,
  );
  static TextStyle openSansSemiBoldWhite12 = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.openSansSemiBold,
    fontSize: 12.0.sp,
  );
  static TextStyle openSansLightWhite12 = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.openSansLight,
    fontSize: 12.0.sp,
  );
  static TextStyle openSansRegularWhite12 = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.openSansRegular,
    fontSize: 12.0.sp,
  );

  /// Open_Sans_Condensed
  static TextStyle openSansCondensedBoldWhite12 = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.openSansCondensedBold,
    fontSize: 12.0.sp,
  );
  static TextStyle openSansCondensedLightWhite12 = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.openSansCondensedLight,
    fontSize: 12.0.sp,
  );
}
