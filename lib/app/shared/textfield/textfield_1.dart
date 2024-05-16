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
  });

  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final String? hintText;
  final Widget? preffixIcon;
  final bool? obsecure;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: normalTextStyle,
      controller: controller,
      autocorrect: false,
      autofillHints: null,
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
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1, color: blueColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
