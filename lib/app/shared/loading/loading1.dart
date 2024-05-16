import 'package:flutter/material.dart';
import 'package:talenta_app/app/shared/theme.dart';

class Loading1 extends StatelessWidget {
  const Loading1({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          strokeCap: StrokeCap.round,
          backgroundColor: Colors.transparent,
          color: blueColor,
          strokeAlign: 3,
          strokeWidth: 3,
        ),
      ),
    );
  }
}
