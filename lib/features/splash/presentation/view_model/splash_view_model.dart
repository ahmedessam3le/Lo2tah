import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lo2tah/app/service_locator.dart';
import 'package:lo2tah/config/routes/app_navigator.dart';
import 'package:lo2tah/core/caching/caching_client.dart';
import 'package:lo2tah/core/enums/caching_keys.dart';
import 'package:lo2tah/features/splash/presentation/view_model/splash_view_states.dart';

import '../../../../config/routes/app_routes.dart';

class SplashViewModel extends Cubit<SplashViewStates> {
  SplashViewModel() : super(SplashInitialState());

  bool isFirstLaunch =
      serviceLocator<CachingClient>().get(
        key: CachingKeys.isFirstLaunch.value,
      ) ??
      true;

  bool _isFirstRetry = true;

  Future<String> _nextScreen() async {
    // AppConstants.user = AppConstants.appBox!.get(AppConstants.userBoxName);
    // if (isOnBoardingSkipped) {
    //   if (AppConstants.user != null) {
    //     var response = await getUserProfileUsecase(context: context);
    //
    //     var route = '';
    //
    //     response.fold(
    //       (failure) {
    //         Logger.print(title: 'GetUserProfile ERROR', message: failure.message);
    //
    //         if (true /*_isFirstRetry*/ ) {
    //           emit(SplashErrorState(failure.message));
    //           _isFirstRetry = !_isFirstRetry;
    //         }
    //         Future.delayed(const Duration(seconds: 10), () => goNext(context));
    //       },
    //       (user) {
    //         AppConstants.user = user;
    //         if (AppConstants.user!.isActive && !AppConstants.user!.isInitialPassword) {
    //           route = AppConstants.determineUserRoute(user: user);
    //           return route;
    //         } else {
    //           route = Routes.loginRoute;
    //           return route;
    //         }
    //       },
    //     );
    //     return route;
    //   } else {
    //     return Routes.loginRoute;
    //   }
    // } else {
    //   return Routes.onBoardingRoute;
    // }

    if (isFirstLaunch) {
      return Routes.onBoardingRoute;
    }
    return Routes.loginRoute;
  }

  Future<void> goNext() async {
    //   if (await di.serviceLocator<InternetConnectionChecker>().hasConnection) {
    //     emit(SplashInternetState());
    //     String? appVersion;
    //
    //     var response = await getAppVersionUsecase(context: context);
    //
    //     response.fold(
    //       (failure) {
    //         emit(SplashErrorState(failure.message));
    //         Logger.print(title: 'GetAppVersion ERROR', message: failure.message);
    //       },
    //       (version) {
    //         appVersion = version;
    //       },
    //     );
    //     if (appVersion != null && di.serviceLocator<AppVersionService>().isUpdateAvailable(appVersion!)) {
    //       AppConstants.navigateAndReplace(context, Routes.appUpdateRoute);
    //     } else {
    //       _nextScreen(context).then((nextRoute) {
    //         if (nextRoute.isNotEmpty) {
    //           AppConstants.navigateAndReplace(context, nextRoute.toString());
    //         }
    //       });
    //     }
    //   } else {
    //     emit(SplashNoInternetState());
    //     Future.delayed(const Duration(seconds: 10), () => goNext(context));
    //   }

    await Future.delayed(const Duration(milliseconds: 750));
    _nextScreen().then((nextRoute) {
      if (nextRoute.isNotEmpty) {
        AppNavigator.navigateTo(isReplace: true, route: nextRoute.toString());
      }
    });
  }
}
