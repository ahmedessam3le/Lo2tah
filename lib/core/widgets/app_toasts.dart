import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:lo2tah/core/enums/caching_keys.dart';

import '../utils/colors_manager.dart';
import '../utils/font_manager.dart';

class AppToasts {
  static void showSuccessToast({
    required BuildContext context,
    required String message,
  }) {
    MotionToast.success(
      description: Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16.sp,
          color: ColorsManager.whiteColor,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      displayBorder: true,
      toastAlignment: Alignment.topCenter,
      toastDuration: const Duration(milliseconds: 2000),
      animationDuration: const Duration(milliseconds: 900),
      height: 70.h,
      width: MediaQuery.of(context).size.width - 20.w,
      borderRadius: 0.r,
      iconSize: 50.r,
      enableAnimation: true,
      layoutOrientation: ui.TextDirection.ltr,
      animationType: context.locale.languageCode == CachingKeys.enLangCode.value
          ? AnimationType.slideInFromLeft
          : AnimationType.slideInFromRight,
      // iconType: IconType.cupertino,
      dismissable: false,
    ).show(context);
  }

  static void showErrorToast({
    required BuildContext context,
    required String message,
    bool isAutoDismissed = true,
    double padding = 0,
  }) {
    MotionToast.error(
      description: Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 12.sp,
          color: ColorsManager.whiteColor,
        ),
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
      ),
      displayBorder: true,
      toastAlignment: Alignment.topCenter,
      toastDuration: isAutoDismissed
          ? const Duration(milliseconds: 2000)
          : const Duration(hours: 10),
      animationDuration: const Duration(milliseconds: 900),
      width: MediaQuery.of(context).size.width - 20.w,
      borderRadius: 0.r,
      iconSize: 50.r,
      enableAnimation: true,
      layoutOrientation: ui.TextDirection.ltr,
      animationType: context.locale.languageCode == CachingKeys.enLangCode.value
          ? AnimationType.slideInFromLeft
          : AnimationType.slideInFromRight,
      // iconType: IconType.cupertino,
      dismissable: false,
    ).show(context);
  }

  static void showWarningToast({
    required BuildContext context,
    required String message,
  }) {
    MotionToast.warning(
      description: Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16.sp,
          color: ColorsManager.whiteColor,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      displayBorder: true,
      toastAlignment: Alignment.topCenter,
      toastDuration: const Duration(milliseconds: 2000),
      animationDuration: const Duration(milliseconds: 900),
      height: 70.h,
      width: MediaQuery.of(context).size.width - 20.w,
      borderRadius: 0.r,
      iconSize: 50.r,
      enableAnimation: true,
      layoutOrientation: ui.TextDirection.ltr,
      animationType: context.locale.languageCode == CachingKeys.enLangCode.value
          ? AnimationType.slideInFromLeft
          : AnimationType.slideInFromRight,
      // iconType: IconType.cupertino,
      dismissable: false,
    ).show(context);
  }

  static void showInfoToast({
    required BuildContext context,
    required String message,
  }) {
    MotionToast.info(
      description: Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16.sp,
          color: ColorsManager.whiteColor,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      displayBorder: true,
      toastAlignment: Alignment.topCenter,
      toastDuration: const Duration(milliseconds: 2000),
      animationDuration: const Duration(milliseconds: 900),
      height: 70.h,
      width: MediaQuery.of(context).size.width - 20.w,
      borderRadius: 0.r,
      iconSize: 50.r,
      enableAnimation: true,
      layoutOrientation: ui.TextDirection.ltr,
      animationType: context.locale.languageCode == CachingKeys.enLangCode.value
          ? AnimationType.slideInFromLeft
          : AnimationType.slideInFromRight,
      dismissable: false,
    ).show(context);
  }

  static void showDeleteToast({
    required BuildContext context,
    required String message,
  }) {
    MotionToast.delete(
      description: Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16.sp,
          color: ColorsManager.whiteColor,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      displayBorder: true,
      toastAlignment: Alignment.topCenter,
      toastDuration: const Duration(milliseconds: 2000),
      animationDuration: const Duration(milliseconds: 900),
      height: 70.h,
      width: MediaQuery.of(context).size.width - 20.w,
      borderRadius: 0.r,
      iconSize: 50.r,
      enableAnimation: true,
      layoutOrientation: ui.TextDirection.ltr,
      animationType: context.locale.languageCode == CachingKeys.enLangCode.value
          ? AnimationType.slideInFromLeft
          : AnimationType.slideInFromRight,
      // iconType: IconType.cupertino,
      dismissable: false,
    ).show(context);
  }
}
