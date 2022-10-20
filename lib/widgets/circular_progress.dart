import 'package:flutter/material.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/styles.dart';

class CircularProgressWidget extends StatelessWidget {
  final String? loadingText;
  const CircularProgressWidget({Key? key, this.loadingText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator.adaptive(
            backgroundColor: ColorUtils.primary,
            valueColor: AlwaysStoppedAnimation<Color>(ColorUtils.background),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          loadingText ?? "Loading...",
          style: TextStyles.loadingStyle,
        ),
      ],
    );
  }
}
