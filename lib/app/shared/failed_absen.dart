import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:talenta_app/app/shared/theme.dart';

class FailedAbsen extends StatelessWidget {
  const FailedAbsen({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Container(
        width: Get.width * 0.95,
        height: Get.height * 0.45,
        color: Colors.white,
        child: Column(
          children: [
            Image.asset(
              "assets/images/ic_warning.png",
              fit: BoxFit.fitWidth,
            ),
            Text(
              "Terjadi Kesalahan Server",
              style: redTextStyle.copyWith(
                fontWeight: medium,
                fontSize: 20,
              ),
            ),
            const Gap(10),
            Text(
              'coba lagi absensi jika masih tidak bisa silahkan hubungi admin Personalia/AGS',
              textAlign: TextAlign.center,
              style: blackTextStyle.copyWith(
                fontSize: 14,
                fontWeight: regular,
              ),
            )
          ],
        ),
      ),
    );
  }
}
