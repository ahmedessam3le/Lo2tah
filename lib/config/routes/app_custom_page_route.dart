import 'package:flutter/material.dart';
import 'package:lo2tah/config/routes/app_routes.dart';

class AppCustomPageRoute<T> extends MaterialPageRoute<T> {
  AppCustomPageRoute({required super.builder, super.settings});

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (settings.name == Routes.initialRoute) {
      return child;
    }

    return FadeTransition(opacity: animation, child: child);
  }
}
