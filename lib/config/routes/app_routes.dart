import 'package:flutter/material.dart';
import 'package:lo2tah/config/routes/app_custom_page_route.dart';
import 'package:lo2tah/features/change_password/presentation/views/change_password_view.dart';
import 'package:lo2tah/features/home/presentation/views/home_view.dart';

import '../../core/utils/strings_manager.dart';
import '../../features/login/presentation/views/login_view.dart';
import '../../features/onboarding/presentation/views/onboarding_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';

class Routes {
  static const String initialRoute = '/';
  static const String onBoardingRoute = '/onBoarding-view';
  static const String loginRoute = '/login-view';
  static const String profileRoute = '/profile-view';
  static const String settingsRoute = '/settings-view';
  static const String homeRoute = '/home-view';
  static const String changePasswordRoute = '/change-password-view';
  static const String supervisorHomeRoute = '/supervisor-home-view';
  static const String filteredVisitsRoute = '/filtered-visits-view';
  static const String visitDetailsRoute = '/visit-details-view';
  static const String categoryGalleryRoute = '/category-gallery-view';
  static const String appUpdateRoute = '/app-update-view';
  static const String emergentVisitsRoute = '/emergent-visits-view';
  static const String notificationDetailsRoute = '/notification-details-view';
  static const String headHomeRoute = '/head-home-view';
  static const String categoryBrandsRoute = '/category-brands-view';
}

class RouteGenerator {
  ///getRoute method is used to return the proper screen according to RouteSettings name.
  static Route? getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return AppCustomPageRoute(builder: (context) => const SplashView());

      case Routes.onBoardingRoute:
        return AppCustomPageRoute(builder: (context) => const OnBoardingView());

      case Routes.loginRoute:
        return AppCustomPageRoute(builder: (context) => const LoginView());

      case Routes.changePasswordRoute:
        return AppCustomPageRoute(
          builder: (context) => const ChangePasswordView(),
        );

      case Routes.homeRoute:
        return AppCustomPageRoute(builder: (context) => const HomeView());
      //
      // case Routes.salesScheduleRoute:
      //   return MaterialPageRoute(
      //     builder: (context) => const MerchandiserAppDrawer(),
      //   );
      //
      // case Routes.profileRoute:
      //   return MaterialPageRoute(
      //     builder: (context) => const ProfileView(),
      //   );
      //
      // case Routes.settingsRoute:
      //   return MaterialPageRoute(
      //     builder: (context) => const SettingsView(),
      //   );

      default:
        return undefinedRoute();
    }
  }

  /// undefinedRoute is returned in case of trying to present a screen that is not found.
  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) =>
          const Scaffold(body: Center(child: Text(AppStrings.noRouteFound))),
    );
  }
}
