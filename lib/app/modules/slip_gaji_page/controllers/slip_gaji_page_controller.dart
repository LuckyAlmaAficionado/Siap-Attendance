import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:talenta_app/app/shared/button/button_1.dart';
import 'package:talenta_app/app/shared/textfield/textfield_1.dart';
import 'package:talenta_app/app/shared/theme.dart';

class SlipGajiPageController extends GetxController {
  RxBool isObsecure = true.obs;

  @override
  void onInit() async {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.bottomSheet(
        isDismissible: false,
        backgroundColor: whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        Container(
          width: Get.width,
          height: 200,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Masukan Password",
                style: normalTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: semiBold,
                ),
              ),
              const Gap(10),
              Obx(() => TextField1(
                    hintText: "Input password",
                    obsecure: isObsecure.value,
                    maxLines: 1,
                    suffixIcon: GestureDetector(
                      onTap: () => isObsecure.toggle(),
                      child: HeroIcon(
                        (!isObsecure.value)
                            ? HeroIcons.eye
                            : HeroIcons.eyeSlash,
                      ),
                    ),
                    preffixIcon: HeroIcon(HeroIcons.lockClosed),
                  )),
              const Gap(15),
              Button1(
                title: "Lanjutkan",
                onTap: () {},
              ),
            ],
          ),
        ),
      );
    });
  }

  Future checkUsers() async {
    log("bottomsheet");
    Get.bottomSheet(Container(
      width: Get.width,
      child: Column(
        children: [
          Text(
            "Masukan Password",
            style: normalTextStyle.copyWith(
              fontSize: 14,
              fontWeight: medium,
            ),
          ),
          TextField1(),
          const Gap(5),
          Button1(title: "Lampirkan"),
        ],
      ),
    ));
  }
}
