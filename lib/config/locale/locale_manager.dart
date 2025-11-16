import 'dart:ui';

import 'package:lo2tah/app/service_locator.dart';
import 'package:lo2tah/core/caching/caching_client.dart';
import 'package:lo2tah/core/enums/caching_keys.dart';

import '../../core/utils/constants_manager.dart';

class LocaleManager {
  Locale getLocale() {
    switch (serviceLocator<CachingClient>().get(
          key: CachingKeys.languageCode.value,
        ) ??
        PlatformDispatcher.instance.locales.first.languageCode) {
      case CachingKeys.enLangCode:
        return AppConstants.englishLocale;

      case CachingKeys.arLangCode:
        return AppConstants.arabicLocale;

      default:
        return AppConstants.englishLocale;
    }
  }

  void setLocale(Locale locale) {
    serviceLocator<CachingClient>().set(
      key: CachingKeys.languageCode.value,
      value: locale.languageCode,
    );
  }
}
