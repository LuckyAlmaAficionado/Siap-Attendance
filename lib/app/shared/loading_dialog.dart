import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:talenta_app/app/shared/theme.dart';

class LoadingDialog extends StatelessWidget {
  final String text;
  final IconData icon;

  LoadingDialog({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: EdgeInsets.all(20),
        width: Get.width * 0.1,
        height: Get.width * 0.5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Lottie.asset("assets/lottie/ani_loading.json"),
            ),
            SizedBox(height: 10),
            Text(
              text,
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
