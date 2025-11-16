import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lo2tah/core/widgets/app_toasts.dart';

import '../../../../app/service_locator.dart';
import '../../../../core/services/app_version_service.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/widgets/no_internet_widget.dart';
import '../view_model/splash_view_model.dart';
import '../view_model/splash_view_states.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late SplashViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = serviceLocator<SplashViewModel>();
  }

  @override
  void didChangeDependencies() {
    _viewModel.goNext();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _viewModel,
      child: BlocConsumer<SplashViewModel, SplashViewStates>(
        listener: (context, state) {
          if (state is SplashErrorState) {
            AppToasts.showErrorToast(
              context: context,
              message: state.error.tr(),
              isAutoDismissed: false,
            );
          }
        },
        builder: (context, state) {
          if (state is SplashNoInternetState) {
            return const NoInternetWidget();
          } else {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Material(
                        shape: const CircleBorder(),
                        color: Colors.transparent,
                        child: CircleAvatar(
                          radius: 100.h,
                          backgroundColor: Theme.of(
                            context,
                          ).scaffoldBackgroundColor,
                          child: Image.asset(
                            ImageAssetsManager.splashLogo,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 40.h),
                      child: Text(
                        '${AppStrings.appVersion.tr()} : ${serviceLocator<AppVersionService>().currentAppVersion}',
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
