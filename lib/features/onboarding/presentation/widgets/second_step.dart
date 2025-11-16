import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lo2tah/features/onboarding/presentation/widgets/curve_clipper.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/colors_manager.dart';
import '../../../../core/utils/strings_manager.dart';

class SecondStep extends StatelessWidget {
  const SecondStep({super.key});

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
          Positioned(
            top: 175.h,
            left: 5.w,
            right: 5.w,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.w),
              child: SvgPicture.asset(ImageAssetsManager.boardingTwoIC),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
              top: 240.h,
              start: 40.w,
              end: 40.w,
            ),
            child: Center(
              child: Text(
                AppStrings.onBoardingTwo.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: 18.sp,
                  color: ColorsManager.offWhiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
