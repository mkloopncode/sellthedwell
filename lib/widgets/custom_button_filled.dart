// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:sellthedwell/utils/colors.dart';

class CustomFillButton extends StatelessWidget {
  final onTapFunction;
  final String childText;
  final bool inverted;
  final IconData? icon;
  final Color? color;
  final double height;
  const CustomFillButton({
    Key? key,
    required this.onTapFunction,
    required this.childText,
    this.inverted = false,
    this.color,
    this.icon,
    this.height = 48,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return icon == null
        ? ElevatedButton(
            onPressed: onTapFunction,
            style: ElevatedButton.styleFrom(
              primary: inverted
                  ? ColorUtils.background
                  : color ?? ColorUtils.primary,
              elevation: 2,
              minimumSize: Size(0, height),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: inverted
                      ? ColorUtils.backgroundDark
                      : color ?? ColorUtils.primary,
                ),
              ),
            ),
            child: Text(
              childText,
              style: TextStyle(
                color: inverted ? ColorUtils.secondaryDark : Colors.white,
              ),
            ),
          )
        : ElevatedButton(
            onPressed: onTapFunction,
            style: ElevatedButton.styleFrom(
              primary: inverted
                  ? ColorUtils.background
                  : color ?? ColorUtils.primary,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: inverted
                      ? ColorUtils.backgroundDark
                      : color ?? ColorUtils.primary,
                ),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  childText,
                  style: TextStyle(
                    color: inverted ? ColorUtils.secondaryDark : Colors.white,
                  ),
                ),
              ],
            ));
  }
}
