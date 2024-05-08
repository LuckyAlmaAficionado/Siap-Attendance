// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:talenta_app/app/controllers/authentication_controller.dart';
import 'package:talenta_app/app/modules/akun_services/pengaturan/views/reset_pin_view.dart';
import 'package:talenta_app/app/modules/akun_services/pengaturan/views/set_new_pin.dart';
import 'package:talenta_app/app/routes/app_pages.dart';
import 'package:talenta_app/app/shared/theme.dart';

class PinView extends GetView {
  PinView({Key? key}) : super(key: key);

  AuthenticationController controller = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "PIN",
            style: appBarTextStyle,
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              color: whiteColor,
            ),
          ),
        ),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Aktifkan PIN",
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      new Spacer(),
                      Obx(() => Switch(
                          value: controller.isPinActivated.value,
                          activeColor: darkBlueColor,
                          onChanged: (value) async {
                            print(controller.isPinActivated.value);
                            if (controller.isPinActivated.value) {
                              // jika pin aktif
                              // await controller.resetPin();
                              Get.toNamed(
                                Routes.VALIDATOR_PIN,
                                arguments: "non-aktif",
                              );
                            } else {
                              // Get.toNamed(Routes.VALIDATOR_PIN,
                              //     arguments: "aktif");
                              // jika pin tidak aktif
                              Get.to(SetNewPinView());
                            }
                          })),
                    ],
                  ),
                ],
              ),
            ),
            Obx(() => (!controller.isPinActivated.value)
                ? SizedBox()
                : Column(
                    children: [
                      Divider(
                        thickness: 1,
                        color: darkGreyColor,
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Aktifkan PIN",
                                      style: blackTextStyle.copyWith(
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      width: Get.width * 0.75,
                                      child: Text(
                                        "Anda harus memasukan PIN untuk mengakses Aplikasi Berbakat",
                                        maxLines: 2,
                                        style: darkGreyTextStyle.copyWith(
                                          fontSize: 14,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                new Spacer(),
                                Obx(
                                  () => Switch(
                                    value: controller
                                        .isNeededPinWhenOpenApps.value,
                                    activeColor: darkBlueColor,
                                    onChanged: (value) =>
                                        controller.usePinWhenOpenApp(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: darkGreyColor,
                      ),
                      InkWell(
                        onTap: () => Get.to(
                          ResetPinView(),
                          transition: Transition.cupertino,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Ubah PIN",
                                    style: blackTextStyle.copyWith(
                                      fontSize: 16,
                                    ),
                                  ),
                                  new Spacer(),
                                  Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    color: darkGreyColor,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))
          ],
        ));
  }
}
