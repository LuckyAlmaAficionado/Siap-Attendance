import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';

import 'package:talenta_app/app/shared/utils.dart';

import '../../../shared/theme.dart';
import '../controllers/validator_pin_controller.dart';

// ignore: must_be_immutable
class ValidatorPinView extends GetView<ValidatorPinController> {
  ValidatorPinView({Key? key}) : super(key: key);

  var argument = Get.arguments ?? "signin";
  final controller = Get.put(ValidatorPinController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        title: Text(
          "Enter Your PIN",
          style: blackTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: HeroIcon(
            HeroIcons.chevronLeft,
            color: Colors.grey,
          ),
          // icon: Icon(
          //   Iconsax.arrow_left,
          //   color: darkGreyColor,
          // ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                6,
                (index) => Container(
                  height: 12,
                  width: 12,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: index < controller.enteredPin.value.length
                        ? blueColor
                        : darkGreyColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 200),
            height: Get.height * 0.5,
            width: Get.width,
            color: darkGreyColor,
            child: Column(
              children: [
                Container(
                  width: Get.width,
                  height: (Get.height * 0.5) / 4,
                  decoration: BoxDecoration(color: Colors.red),
                  child: Row(
                    children: List.generate(
                      3,
                      (index) => Expanded(
                        child: Material(
                          elevation: 3,
                          child: InkWell(
                            onTap: () {
                              controller.enteredPin.value += "${index + 1}";
                              checkingLenght();
                            },
                            child: Center(
                              child: Text(
                                "${index + 1}",
                                style: blackTextStyle.copyWith(
                                  fontWeight: semiBold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: Get.width,
                  height: (Get.height * 0.5) / 4,
                  decoration: BoxDecoration(color: Colors.red),
                  child: Row(
                    children: List.generate(
                      3,
                      (index) => Expanded(
                        child: Material(
                          elevation: 3,
                          child: InkWell(
                            onTap: () {
                              controller.enteredPin.value += "${index + 4}";
                              checkingLenght();
                            },
                            child: Center(
                              child: Text(
                                "${index + 4}",
                                style: blackTextStyle.copyWith(
                                  fontWeight: semiBold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: Get.width,
                  height: (Get.height * 0.5) / 4,
                  decoration: BoxDecoration(color: Colors.red),
                  child: Row(
                    children: List.generate(
                      3,
                      (index) => Expanded(
                        child: Material(
                          elevation: 3,
                          child: InkWell(
                            onTap: () {
                              controller.enteredPin.value += "${index + 7}";
                              checkingLenght();
                            },
                            child: Center(
                              child: Text(
                                "${index + 7}",
                                style: blackTextStyle.copyWith(
                                  fontWeight: semiBold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: Get.width,
                  height: (Get.height * 0.5) / 4,
                  decoration: BoxDecoration(color: Colors.red),
                  child: Row(
                    children: List.generate(3, (index) {
                      List buttonValue = [
                        Icon(
                          Icons.fingerprint,
                          size: 40,
                        ),
                        Text(
                          "0",
                          style: blackTextStyle.copyWith(
                            fontWeight: semiBold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "",
                        ),
                      ];
                      return Expanded(
                        child: Material(
                          elevation: 3,
                          child: InkWell(
                            onTap: () {
                              if (index == 0) {
                                if (true) {
                                  controller.checkLocalAuthentication(argument);
                                } else {
                                  Utils().snackbarC(
                                    "Informasi",
                                    "Anda belum mengaktifkan fitur ini",
                                    true,
                                  );
                                }
                              } else if (index == 1) {
                                controller.enteredPin.value += "0";
                                checkingLenght();
                              }
                            },
                            child: Center(
                              child: buttonValue[index],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void checkingLenght() {
    if (controller.enteredPin.value.length == 6) {
      controller.validatorC.text = controller.enteredPin.value;
      controller.checkPin(argument);
      controller.enteredPin.value = '';
    }
  }
}
