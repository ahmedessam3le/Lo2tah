import 'package:lo2tah/core/utils/strings_manager.dart';

enum Flavor {
  dev('dev', '${AppStrings.appName} Dev'),
  stage('stage', '${AppStrings.appName} Stage'),
  prod('prod', AppStrings.appName);

  final String type;
  final String appName;

  const Flavor(this.type, this.appName);
}
