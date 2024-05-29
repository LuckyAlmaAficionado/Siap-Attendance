import 'package:flutter/material.dart';

import '../theme.dart';

class TextField1 extends StatelessWidget {
  TextField1({
    super.key,
    this.controller,
    this.suffixIcon,
    this.obsecure,
    this.preffixIcon,
    this.hintText,
    this.textInputAction,
    this.onChanged,
    this.onTap,
    this.readOnly,
  });

  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final String? hintText;
  final Widget? preffixIcon;
  final bool? obsecure;
  final Function(String)? onChanged;
  final Function()? onTap;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: normalTextStyle,
      readOnly: readOnly ?? false,
      controller: controller,
      autocorrect: false,
      autofillHints: null,
      onTap: onTap,
      onChanged: onChanged,
      obscureText: obsecure ?? false,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        fillColor: lightGreyColor,
        suffixIcon: suffixIcon,
        prefixIcon: preffixIcon,
        hintText: hintText,
        hintStyle: normalTextStyle.copyWith(
          fontWeight: regular,
          color: darkGreyColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(width: 1, color: blueColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.5, color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
