import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lo2tah/config/routes/app_navigator.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final Widget? leading;
  final bool? isCenterTitle;
  final PreferredSizeWidget? bottomTabBar;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.actions,
    this.leading,
    this.bottomTabBar,
    this.isCenterTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: isCenterTitle ?? true,
      surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      automaticallyImplyLeading: false,
      leadingWidth: 60.w,
      bottom: bottomTabBar,
      title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
      leading: showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios, size: 27.r),
              color: Theme.of(context).indicatorColor,
              onPressed: () {
                AppNavigator.pop(context);
              },
            )
          : leading,
      actions: actions ?? [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
