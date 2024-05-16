import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:talenta_app/app/routes/app_pages.dart';
import 'package:talenta_app/app/shared/button/button_1.dart';
import 'package:talenta_app/app/shared/theme.dart';

class AlertOutRange extends StatelessWidget {
  const AlertOutRange({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: Container(
        width: context.width * 0.6,
        height: context.width * 0.7,
        child: Column(
          children: [
            Image.asset(
              "assets/images/img_onboarding1.png",
              width: 160,
              height: 160,
            ),
            const Gap(10),
            Text(
              "PERINGATAN",
              style: normalTextStyle.copyWith(
                color: redColor,
                fontSize: 22,
                fontWeight: semiBold,
              ),
            ),
            const Gap(5),
            Text(
              "Anda berada diluar jangkauan",
              style: normalTextStyle,
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                      height: 40,
                      child: Button1(
                        title: "Kembali",
                        color: darkGreyColor,
                        onTap: () => Get.back(),
                      )),
                ),
                const Gap(10),
                Expanded(
                  child: SizedBox(
                      height: 40,
                      child: Button1(
                        title: "Tetap Absen",
                        color: redColor,
                        onTap: () => Get.offNamed(Routes.CAMERA_PAGE),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
