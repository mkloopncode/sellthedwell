import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/styles.dart';

class CustomTextButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final Color? color;
  final IconData? icon;
  const CustomTextButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.color,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon != null
              ? Icon(
                  icon,
                  color: color ?? ColorUtils.textButtonColor,
                )
              : const SizedBox.shrink(),
          const SizedBox(
            width: 8,
          ),
          Text(
            text,
            style: TextStyles.heading4.copyWith(
              color: color ?? ColorUtils.textButtonColor,
            ),
          ),
        ],
      ),
    );
  }
}
