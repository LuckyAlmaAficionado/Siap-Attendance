import 'package:flutter/material.dart';
import 'package:talenta_app/app/shared/utils.dart';

class ErrorAlert extends StatelessWidget {
  const ErrorAlert({super.key, required this.text});

  final String text;

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
            Text(text),
          ],
        ),
      ),
    );
  }
}
