import 'package:flutter/material.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String labelText;
  final TextInputType keyboardType;
  final bool isRequired;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool readOnly;
  final void Function()? onTap;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final int minLines;
  final int maxLines;
  final TextStyle? style;

  const CustomTextFieldWidget({
    Key? key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.keyboardType = TextInputType.text,
    required this.isRequired,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.minLines = 1,
    this.maxLines = 1,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
      minLines: minLines,
      maxLines: maxLines,
      // if validator is null and it required, send error text
      validator: validator ??
          (isRequired
              ? (str) {
                  if ((str ?? "").isEmpty) {
                    return Strings.requiredErrorText;
                  }
                  return null;
                }
              : null),
      style: style,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        filled: true,
        fillColor: ColorUtils.textFieldFillColor,
        suffix: suffixIcon == null
            ? null
            : Icon(
                suffixIcon,
                color: ColorUtils.textColor,
              ),
        prefixIcon: prefixIcon == null
            ? null
            : Icon(
                prefixIcon,
                color: ColorUtils.textColor,
              ),
        labelText: labelText,
        hintText: hintText ?? labelText,
        labelStyle: TextStyles.textFieldLabelTextStyle,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: ColorUtils.textFieldFillColor.withOpacity(0.2),
            width: 0,
          ),
        ),
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: ColorUtils.textFieldFillColor.withOpacity(0.5),
            width: 0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            style: BorderStyle.solid,
            color: ColorUtils.secondaryDark,
            width: 1,
          ),
        ),
      ),
    );
  }
}
