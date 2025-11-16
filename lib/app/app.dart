import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lo2tah/app/app_bloc_observer.dart';
import 'package:lo2tah/app/service_locator.dart';

import '../config/locale/locale_manager.dart';
import '../config/routes/app_navigator.dart';
import '../config/routes/app_routes.dart';
import '../core/enums/flavor_enum.dart';
import '../core/services/app_version_service.dart';
import '../core/utils/assets_manager.dart';
import '../core/utils/colors_manager.dart';
import '../core/utils/constants_manager.dart';
import '../core/utils/strings_manager.dart';
import '../core/utils/theme_manager.dart';
import '../core/view_models/app/app_view_model.dart';
import '../core/view_models/app/app_view_model_states.dart';

Future<Widget> initializeApp(Flavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await init(flavor);

  Bloc.observer = AppBlocObserver();

  await serviceLocator<AppViewModel>().init();
  await serviceLocator<AppVersionService>().init();

  return EasyLocalization(
    supportedLocales: AppConstants.supportedLocales,
    path: translationsPath,
    fallbackLocale: AppConstants.englishLocale,
    startLocale: serviceLocator<LocaleManager>().getLocale(),
    saveLocale: true,
    child: lo2tahApp(flavor),
  );
}

class lo2tahApp extends StatefulWidget {
  final Flavor flavor;

  const lo2tahApp(this.flavor, {Key? key}) : super(key: key);

  @override
  State<lo2tahApp> createState() => _lo2tahAppState();
}

class _lo2tahAppState extends State<lo2tahApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return serviceLocator<AppViewModel>()..getSavedTheme();
          },
        ),
      ],
      child: BlocConsumer<AppViewModel, AppStates>(
        listener: (context, state) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: state.isDark!
                  ? ColorsManager.scaffoldBackgroundColor
                  : ColorsManager.whiteColor,
              statusBarIconBrightness: state.isDark!
                  ? Brightness.light
                  : Brightness.dark,
              systemNavigationBarColor: state.isDark!
                  ? ColorsManager.scaffoldBackgroundColor
                  : ColorsManager.whiteColor,
              systemNavigationBarIconBrightness: state.isDark!
                  ? Brightness.light
                  : Brightness.dark,
            ),
          );
        },
        builder: (context, state) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: state.isDark!
                  ? ColorsManager.scaffoldBackgroundColor
                  : ColorsManager.whiteColor,
              statusBarIconBrightness: state.isDark!
                  ? Brightness.light
                  : Brightness.dark,
              systemNavigationBarColor: state.isDark!
                  ? ColorsManager.scaffoldBackgroundColor
                  : ColorsManager.whiteColor,
              systemNavigationBarIconBrightness: state.isDark!
                  ? Brightness.light
                  : Brightness.dark,
            ),
          );
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: widget.flavor != Flavor.prod,
                title: AppStrings.appName,
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: state.isDark! ? ThemeMode.dark : ThemeMode.light,
                navigatorKey: AppNavigator.navigatorState,
                onGenerateRoute: RouteGenerator.getRoute,
                initialRoute: Routes.initialRoute,
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,
                locale: context.locale,
              );
            },
          );
        },
      ),
    );
  }
}
