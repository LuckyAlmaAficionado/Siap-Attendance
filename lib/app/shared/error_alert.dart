import 'package:flutter/material.dart';
import 'package:talenta_app/app/shared/theme.dart';
import 'package:talenta_app/app/shared/utils.dart';

class ErrorAlert extends StatelessWidget {
  const ErrorAlert({super.key, required this.msg, required this.methodName});

  final String msg;
  final String methodName;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        CustomButton(
          title: "Kembali",
          onTap: () => Navigator.pop(context),
        )
      ],
      content: Container(
        width: 400,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Text(
              methodName,
              style: normalTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
            Text(
              msg,
              style: normalTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
