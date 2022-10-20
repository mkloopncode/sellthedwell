import 'package:flutter/material.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? titleWidget;
  final bool? isBackShown;
  final bool? isCenter;
  final List<Widget>? actions;
  const CustomAppBar({
    Key? key,
    this.isBackShown = true,
    this.isCenter = true,
    this.titleWidget = const SizedBox.shrink(),
    this.actions = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      title: titleWidget,
      backgroundColor: ColorUtils.white,
      elevation: 0,
      titleTextStyle: TextStyles.appBarTitle,
      centerTitle: isCenter,
      leading: (isBackShown ?? false)
          ? IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: ColorUtils.textColor,
              ),
            )
          : IconButton(
              icon: const Icon(
                Icons.menu,
                color: ColorUtils.textColor,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64.0);
}

class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final List<Widget> actions;
  final Widget? title;
  const CustomAppBar2({
    Key? key,
    required this.context,
    this.title,
    this.actions = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      backgroundColor: ColorUtils.white,
      elevation: 0,
      titleTextStyle: TextStyles.appBarTitle,
      title: title ?? const SizedBox.shrink(),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: ColorUtils.black,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64.0);
}
