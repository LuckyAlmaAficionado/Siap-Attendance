import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:talenta_app/app/shared/theme.dart';
import 'package:talenta_app/app/shared/utils.dart';

class ConnectionController extends GetxController {
  validatorConnection(BuildContext context) async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      print('YAY! Free cute dog pics!');
    } else {
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        builder: (context) => Container(
          width: Get.width,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset(
                  "assets/images/no-wifi.png",
                  fit: BoxFit.contain,
                ),
              ),
              const Gap(20),
              Text(
                "No Internet Connection",
                style: blackTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 18,
                ),
              ),
              const Gap(30),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomButton(
                  title: "Kembali",
                  onTap: () {
                    Get.back();
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      );
      print('No internet :( Reason:');
    }
  }
}
