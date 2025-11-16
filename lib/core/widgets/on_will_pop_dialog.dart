import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lo2tah/core/widgets/app_dialogs.dart';

import '../utils/strings_manager.dart';

class OnWillPopDialog {
  final BuildContext context;

  OnWillPopDialog({required this.context});

  Future<bool> onWillPop() async {
    return AppDialogs.showConfirmDialog(
      context: context,
      title: AppStrings.exitAppTitle.tr(),
      message: AppStrings.exitAppContent.tr(),
      confirmButtonLabel: AppStrings.exit.tr(),
      confirmButtonColor: Theme.of(context).primaryColorDark,
      onConfirmButtonPressed: () => SystemNavigator.pop(),
      cancelButtonLabel: AppStrings.no.tr(),
      onCancelButtonPressed: () =>
          Navigator.of(context, rootNavigator: true).pop(),
    );
  }
}
