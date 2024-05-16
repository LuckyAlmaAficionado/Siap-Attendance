import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talenta_app/app/shared/theme.dart';

class Button1 extends StatelessWidget {
  const Button1({
    super.key,
    this.onTap,
    required this.title,
    this.color,
  });

  final Function()? onTap;
  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: Get.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: color ?? Colors.blue[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onTap,
        child: Text(
          "$title",
          style: normalTextStyle.copyWith(
            fontWeight: regular,
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
