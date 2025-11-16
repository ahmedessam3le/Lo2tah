import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lo2tah/app/app_flavor.dart';
import 'package:lo2tah/core/caching/caching_client.dart';
import 'package:lo2tah/core/caching/shared_prefs_client.dart';
import 'package:lo2tah/features/change_password/presentation/view_models/change_password_view_model.dart';
import 'package:lo2tah/features/home/presentation/view_model/home_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/locale/locale_manager.dart';
import '../core/api/api_consumer.dart';
import '../core/api/app_interceptors.dart';
import '../core/api/dio_consumer.dart';
import '../core/enums/flavor_enum.dart';
import '../core/network/network_info.dart';
import '../core/services/app_version_service.dart';
import '../core/view_models/app/app_view_model.dart';
import '../features/login/presentation/view_model/login_view_model.dart';
import '../features/onboarding/presentation/view_model/onboarding_view_model.dart';
import '../features/splash/presentation/view_model/splash_view_model.dart';

final serviceLocator = GetIt.instance;

Future<void> init(Flavor flavor) async {
  // 1 - Features
  // a) Blocs

  serviceLocator.registerFactory<AppViewModel>(() => AppViewModel());

  serviceLocator.registerFactory<SplashViewModel>(() => SplashViewModel());

  serviceLocator.registerFactory<OnBoardingViewModel>(
    () => OnBoardingViewModel(),
  );

  serviceLocator.registerFactory<LoginViewModel>(() => LoginViewModel());

  serviceLocator.registerFactory<ChangePasswordViewModel>(
    () => ChangePasswordViewModel(),
  );

  serviceLocator.registerLazySingleton<HomeViewModel>(() => HomeViewModel());

  // b) Use Cases

  // serviceLocator.registerLazySingleton<LoginUsecase>(
  //   () => LoginUsecase(
  //     loginRepository: serviceLocator(),
  //   ),
  // );
  //
  // serviceLocator.registerLazySingleton<ChangePasswordUsecase>(
  //   () => ChangePasswordUsecase(
  //     changePasswordRepository: serviceLocator(),
  //   ),
  // );
  //
  // serviceLocator.registerLazySingleton<GetUserProfileUsecase>(
  //   () => GetUserProfileUsecase(
  //     getUserProfileRepository: serviceLocator(),
  //   ),
  // );
  //
  // serviceLocator.registerLazySingleton<LogoutUsecase>(
  //   () => LogoutUsecase(
  //     logoutRepository: serviceLocator(),
  //   ),
  // );

  // c) Repositories

  // serviceLocator.registerLazySingleton<LoginRepository>(
  //   () => LoginRepositoryImpl(
  //     loginRemoteDataSource: serviceLocator(),
  //     loginLocalDataSource: serviceLocator(),
  //   ),
  // );
  //
  // serviceLocator.registerLazySingleton<ChangePasswordRepository>(
  //   () => ChangePasswordRepositoryImpl(
  //     changePasswordRemoteDataSource: serviceLocator(),
  //   ),
  // );
  //
  // serviceLocator.registerLazySingleton<GetUserProfileRepository>(
  //   () => GetUserProfileRepositoryImpl(
  //     getUserProfileRemoteDataSource: serviceLocator(),
  //     getUserProfileLocalDataSource: serviceLocator(),
  //   ),
  // );
  //
  // serviceLocator.registerLazySingleton<LogoutRepository>(
  //   () => LogoutRepositoryImpl(
  //     logoutRemoteDataSource: serviceLocator(),
  //     logoutLocalDataSource: serviceLocator(),
  //   ),
  // );

  // d) Data Sources

  // serviceLocator.registerLazySingleton<LoginRemoteDataSource>(
  //   () => LoginRemoteDataSourceImpl(
  //     apiConsumer: serviceLocator(),
  //   ),
  // );
  //
  // serviceLocator.registerLazySingleton<LoginLocalDataSource>(
  //   () => LoginLocalDataSourceImpl(),
  // );
  //
  // serviceLocator.registerLazySingleton<ChangePasswordRemoteDataSource>(
  //   () => ChangePasswordRemoteDataSourceImpl(
  //     apiConsumer: serviceLocator(),
  //   ),
  // );
  //
  // serviceLocator.registerLazySingleton<GetUserProfileRemoteDataSource>(
  //   () => GetUserProfileRemoteDataSourceImpl(
  //     apiConsumer: serviceLocator(),
  //   ),
  // );
  //
  // serviceLocator.registerLazySingleton<GetUserProfileLocalDataSource>(
  //   () => GetUserProfileLocalDataSourceImpl(),
  // );
  //
  // serviceLocator.registerLazySingleton<LogoutRemoteDataSource>(
  //   () => LogoutRemoteDataSourceImpl(
  //     apiConsumer: serviceLocator(),
  //   ),
  // );
  //
  // serviceLocator.registerLazySingleton<LogoutLocalDataSource>(
  //   () => LogoutLocalDataSourceImpl(),
  // );

  // 2 - Core

  serviceLocator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(client: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<CachingClient>(
    () => SharedPreferenceClient(client: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(() => LocaleManager());
  serviceLocator.registerLazySingleton(() => AppFlavor(flavor));
  serviceLocator.registerLazySingleton(() => AppVersionService());

  // 3 - External

  serviceLocator.registerLazySingleton(() => DeviceInfoPlugin());
  serviceLocator.registerLazySingleton(() => Dio());
  serviceLocator.registerLazySingleton(() => AppInterceptors());
  serviceLocator.registerLazySingleton(
    () => InternetConnectionChecker.createInstance(),
  );
  serviceLocator.registerLazySingleton(
    () => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerSingleton<SharedPreferences>(sharedPreferences);
}
