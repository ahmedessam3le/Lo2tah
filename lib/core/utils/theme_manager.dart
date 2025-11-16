import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lo2tah/core/utils/colors_manager.dart';
import 'package:lo2tah/core/utils/text_styles_manager.dart';

/// appTheme is used to handle the ui flavor of the most used widgets

ThemeData lightTheme = ThemeData(
  useMaterial3: true,

  // Main Colors
  primaryColor: ColorsManager.primaryColor,
  primarySwatch: ColorsManager.primarySwatch,
  primaryColorDark: ColorsManager.darkPrimaryColor,
  disabledColor: ColorsManager.greyColor,
  scaffoldBackgroundColor: ColorsManager.offWhiteColor,
  indicatorColor: ColorsManager.scaffoldBackgroundColor,
  unselectedWidgetColor: ColorsManager.whiteColor,
  splashFactory: NoSplash.splashFactory,
  brightness: Brightness.light,
  hintColor: ColorsManager.darkPrimaryColor,
  canvasColor: ColorsManager.scaffoldBackgroundColor,
  focusColor: ColorsManager.darkPrimaryColor,
  hoverColor: ColorsManager.whiteColor,

  // App Bar Theme
  appBarTheme: AppBarTheme(
    centerTitle: true,
    color: ColorsManager.whiteColor,
    titleTextStyle: semiBoldTextStyle(
      fontSize: 18.sp,
      color: ColorsManager.scaffoldBackgroundColor,
    ),
    elevation: 0.r,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: ColorsManager.whiteColor,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
    iconTheme: IconThemeData(
      color: ColorsManager.scaffoldBackgroundColor,
      size: 30.r,
    ),
  ),

  // Text Theme
  textTheme: TextTheme(
    headlineLarge: boldTextStyle(
      fontSize: 20.sp,
      color: ColorsManager.blackColor87,
    ),
    bodyLarge: semiBoldTextStyle(
      fontSize: 18.sp,
      color: ColorsManager.blackColor87,
    ),
    titleMedium: mediumTextStyle(
      fontSize: 17.sp,
      color: ColorsManager.blackColor87,
    ),
    bodyMedium: regularTextStyle(
      fontSize: 16.sp,
      color: ColorsManager.blackColor87,
    ),
    bodySmall: lightTextStyle(
      fontSize: 14.sp,
      color: ColorsManager.blackColor87,
    ),
  ),

  // Text Form Field Theme
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
    hintStyle: regularTextStyle(
      fontSize: 16.sp,
      color: ColorsManager.greyColor,
    ),
    labelStyle: mediumTextStyle(
      fontSize: 17.sp,
      color: ColorsManager.greyColor,
    ),
    errorStyle: mediumTextStyle(fontSize: 16.sp, color: ColorsManager.redColor),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorsManager.greyColor, width: 1.5.w),
      borderRadius: BorderRadius.all(Radius.circular(8.r)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorsManager.primaryColor, width: 1.5.w),
      borderRadius: BorderRadius.all(Radius.circular(8.r)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorsManager.redColor, width: 1.5.w),
      borderRadius: BorderRadius.all(Radius.circular(8.r)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorsManager.redColor, width: 1.5.w),
      borderRadius: BorderRadius.all(Radius.circular(8.r)),
    ),
  ),

  // Button Theme
  buttonTheme: const ButtonThemeData(
    shape: StadiumBorder(),
    buttonColor: ColorsManager.primaryColor,
    splashColor: ColorsManager.primaryColor,
    disabledColor: ColorsManager.greyColor,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: regularTextStyle(
        fontSize: 17.sp,
        color: ColorsManager.whiteColor,
      ),
      backgroundColor: ColorsManager.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    ),
  ),

  // Card Theme
  cardTheme: CardThemeData(
    color: ColorsManager.scaffoldBackgroundColor,
    shadowColor: ColorsManager.lightGreyColor,
    elevation: 4.r,
  ),

  iconTheme: IconThemeData(size: 30.r, color: ColorsManager.primaryColor),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: ColorsManager.scaffoldBackgroundColor,
    elevation: 0.r,
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    color: ColorsManager.whiteColor,
    elevation: 0.r,
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateColor.resolveWith(
      (states) => ColorsManager.primaryColor,
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionHandleColor: ColorsManager.primaryColor,
  ),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,

  // Main Colors
  primaryColor: ColorsManager.primaryColor,
  primarySwatch: ColorsManager.primarySwatch,
  primaryColorDark: ColorsManager.darkPrimaryColor,
  disabledColor: ColorsManager.greyColor,
  scaffoldBackgroundColor: ColorsManager.scaffoldBackgroundColor,
  indicatorColor: ColorsManager.whiteColor,
  unselectedWidgetColor: ColorsManager.scaffoldBackgroundColor,
  splashFactory: NoSplash.splashFactory,
  brightness: Brightness.dark,
  hintColor: ColorsManager.darkPrimaryColor,
  canvasColor: ColorsManager.primaryColor,
  focusColor: ColorsManager.whiteColor,
  hoverColor: ColorsManager.primaryColor,

  // App Bar Theme
  appBarTheme: AppBarTheme(
    centerTitle: true,
    color: ColorsManager.scaffoldBackgroundColor,
    titleTextStyle: semiBoldTextStyle(
      fontSize: 18.sp,
      color: ColorsManager.whiteColor,
    ),
    elevation: 0.r,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: ColorsManager.scaffoldBackgroundColor,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
    iconTheme: IconThemeData(color: ColorsManager.whiteColor, size: 30.r),
  ),

  // Text Theme
  textTheme: TextTheme(
    headlineLarge: boldTextStyle(
      fontSize: 20.sp,
      color: ColorsManager.whiteColor,
    ),
    bodyLarge: semiBoldTextStyle(
      fontSize: 18.sp,
      color: ColorsManager.whiteColor,
    ),
    titleMedium: mediumTextStyle(
      fontSize: 17.sp,
      color: ColorsManager.whiteColor,
    ),
    bodyMedium: regularTextStyle(
      fontSize: 16.sp,
      color: ColorsManager.whiteColor,
    ),
    bodySmall: lightTextStyle(fontSize: 14.sp, color: ColorsManager.whiteColor),
  ),

  // Text Form Field Theme
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.all(8.w),
    hintStyle: regularTextStyle(
      fontSize: 16.sp,
      color: ColorsManager.greyColor,
    ),
    labelStyle: mediumTextStyle(
      fontSize: 17.sp,
      color: ColorsManager.greyColor,
    ),
    errorStyle: mediumTextStyle(fontSize: 16.sp, color: ColorsManager.redColor),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorsManager.greyColor, width: 1.5.w),
      borderRadius: BorderRadius.all(Radius.circular(8.r)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorsManager.primaryColor, width: 1.5.w),
      borderRadius: BorderRadius.all(Radius.circular(8.r)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorsManager.redColor, width: 1.5.w),
      borderRadius: BorderRadius.all(Radius.circular(8.r)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorsManager.redColor, width: 1.5.w),
      borderRadius: BorderRadius.all(Radius.circular(8.r)),
    ),
  ),

  // Button Theme
  buttonTheme: const ButtonThemeData(
    shape: StadiumBorder(),
    buttonColor: ColorsManager.primaryColor,
    splashColor: ColorsManager.primaryColor,
    disabledColor: ColorsManager.greyColor,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: regularTextStyle(
        fontSize: 17.sp,
        color: ColorsManager.whiteColor,
      ),
      backgroundColor: ColorsManager.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    ),
  ),

  // Card Theme
  cardTheme: CardThemeData(
    color: ColorsManager.primaryColor,
    shadowColor: ColorsManager.lightGreyColor,
    elevation: 4.r,
  ),

  iconTheme: IconThemeData(size: 30.r, color: ColorsManager.primaryColor),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: ColorsManager.primaryColor,
    elevation: 0.r,
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    color: ColorsManager.scaffoldBackgroundColor,
    elevation: 0.r,
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateColor.resolveWith(
      (states) => ColorsManager.primaryColor,
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionHandleColor: ColorsManager.primaryColor,
  ),
);
