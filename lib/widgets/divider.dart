import 'package:flutter/material.dart';
import 'package:sellthedwell/utils/colors.dart';

class DividerWidget extends StatelessWidget {
  final double height, indent;
  const DividerWidget({Key? key, this.height = 4, this.indent = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      color: ColorUtils.secondaryLight.withOpacity(0.5),
      indent: indent,
      endIndent: indent,
    );
  }
}
