/// ImageAssetsManager is used to handle the application images instead of statically type
/// the image path each time whe need it.

const String imagesPath = 'assets/images';
const String translationsPath = 'assets/translations';

class ImageAssetsManager {
  static const String appLogo = '$imagesPath/app_logo.png';
  static const String splashLogo = '$imagesPath/splash_logo.png';
  static const String boardingOneIC = '$imagesPath/boarding-1.svg';
  static const String boardingTwoIC = '$imagesPath/boarding-2.svg';
  static const String boardingThreeIC = '$imagesPath/boarding-3.svg';
  static const String englishLogo = '$imagesPath/en_icon.svg';
  static const String arabicLogo = '$imagesPath/ar_icon.svg';
  static const String profilePic = '$imagesPath/profile_pic.png';
  static const String changePasswordIcon =
      '$imagesPath/change_password_icon.gif';
  static const String userDefaultImage = '$imagesPath/user_default_image.jpg';
  static const String noInternetImage = '$imagesPath/no_internet_image.gif';
  static const String celebrationImage = '$imagesPath/celebration.gif';
  static const String noFilesImage = '$imagesPath/no_files.gif';
  static const String googlePlayImage = '$imagesPath/google_play.png';
  static const String infoIcon = '$imagesPath/i.svg';
}
