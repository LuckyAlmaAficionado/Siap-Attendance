import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:talenta_app/app/shared/theme.dart';
import 'package:talenta_app/app/shared/utils.dart';

// ignore: must_be_immutable
class AppsVersionFailed extends StatelessWidget {
  AppsVersionFailed({super.key});

  int value = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (value == 1) {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else {
            exit(0);
          }
        }
        value++;
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Container(
          width: Get.width * 0.95,
          height: Get.height * 0.4,
          color: Colors.white,
          child: Column(
            children: [
              Image.asset(
                "assets/images/ic_warning.png",
                fit: BoxFit.fitWidth,
              ),
              Text(
                "Update Aplikasi Anda",
                style: blueTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 20,
                ),
              ),
              const Gap(10),
              Text(
                'update aplikasi anda sekarang juga..!',
                textAlign: TextAlign.center,
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: regular,
                ),
              )
            ],
          ),
        ),
        actions: [
          CustomButton(
            title: "Kembali",
            onTap: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else {
                exit(0);
              }
            },
          )
        ],
      ),
    );
  }
}
