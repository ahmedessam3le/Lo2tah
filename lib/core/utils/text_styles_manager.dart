import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lo2tah/core/utils/font_manager.dart';

import 'colors_manager.dart';

/// These are the most used text styles overall the application

TextStyle _getTextStyle({
  required double fontSize,
  required FontWeight fontWeight,
  required Color color,
}) {
  return TextStyle(
    fontFamily: FontConstants.fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}

TextStyle lightTextStyle({
  double? fontSize,
  Color color = ColorsManager.whiteColor,
}) {
  fontSize = 14.sp;
  return _getTextStyle(
    fontSize: fontSize,
    fontWeight: FontWeightManager.light,
    color: color,
  );
}

TextStyle regularTextStyle({
  double? fontSize,
  Color color = ColorsManager.whiteColor,
}) {
  fontSize = 16.sp;
  return _getTextStyle(
    fontSize: fontSize,
    fontWeight: FontWeightManager.regular,
    color: color,
  );
}

TextStyle mediumTextStyle({
  double? fontSize,
  Color color = ColorsManager.whiteColor,
}) {
  fontSize = 18.sp;
  return _getTextStyle(
    fontSize: fontSize,
    fontWeight: FontWeightManager.medium,
    color: color,
  );
}

TextStyle semiBoldTextStyle({
  double? fontSize,
  Color color = ColorsManager.whiteColor,
}) {
  fontSize = 20.sp;
  return _getTextStyle(
    fontSize: fontSize,
    fontWeight: FontWeightManager.semiBold,
    color: color,
  );
}

TextStyle boldTextStyle({
  double? fontSize,
  Color color = ColorsManager.whiteColor,
}) {
  fontSize = 22.sp;
  return _getTextStyle(
    fontSize: fontSize,
    fontWeight: FontWeightManager.bold,
    color: color,
  );
}
