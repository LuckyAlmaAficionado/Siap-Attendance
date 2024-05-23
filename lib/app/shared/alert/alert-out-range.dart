import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:talenta_app/app/routes/app_pages.dart';
import 'package:talenta_app/app/shared/button/button_1.dart';
import 'package:talenta_app/app/shared/theme.dart';

class AlertOutRange extends StatelessWidget {
  const AlertOutRange({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: Container(
        width: context.width * 0.9,
        height: context.width * 0.3,
        child: Column(
          children: [
            Text(
              "PERINGATAN",
              style: normalTextStyle.copyWith(
                color: redColor,
                fontSize: 18,
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
                        title: "Absen",
                        color: redColor,
                        onTap: () =>
                            Get.offNamed(Routes.CAMERA_PAGE, arguments: status),
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
