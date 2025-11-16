import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lo2tah/core/utils/assets_manager.dart';
import 'package:lo2tah/core/utils/colors_manager.dart';
import 'package:lo2tah/core/utils/strings_manager.dart';
import 'package:lo2tah/features/onboarding/presentation/widgets/curve_clipper.dart';

class FirstStep extends StatelessWidget {
  const FirstStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.darkPrimaryColor,
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -150.h,
            left: -50.w,
            right: -50.w,
            child: ClipPath(
              clipper: TopCurveClipper(),
              child: Container(
                height: 600.h,
                color: ColorsManager.warmYellowColor, // mustard yellow
              ),
            ),
          ),
          SvgPicture.asset(ImageAssetsManager.boardingOneIC),
          Padding(
            padding: EdgeInsets.only(top: 530.h),
            child: Text(
              AppStrings.onBoardingOne.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 18.sp,
                color: ColorsManager.offWhiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
