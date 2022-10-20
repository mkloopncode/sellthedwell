import 'package:flutter/material.dart';
import 'package:sellthedwell/utils/styles.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final void Function() onTap;
  const CustomOutlinedButton(
      {Key? key, required this.text, this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon == null ? const SizedBox.shrink() : Icon(icon),
            const SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: TextStyles.body2,
            ),
          ],
        ),
      ),
    );
  }
}
