import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:talenta_app/app/shared/theme.dart';

class ConnectionController extends GetxController {
  final Connectivity connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    if (result.first == ConnectivityResult.none) {
      Get.snackbar(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        duration: const Duration(days: 1),
        isDismissible: false,
        backgroundColor: Colors.red.withOpacity(0.05),
        "No Internet Connection",
        "Please Connection To The Internet",
        titleText: Text(
          "No Internet Connection",
          style: normalTextStyle.copyWith(
            fontWeight: bold,
            fontSize: 14,
          ),
        ),
        messageText: Text(
          "Please Connection To The Internet",
          style: normalTextStyle.copyWith(
            color: Colors.red,
            fontWeight: medium,
          ),
        ),
        icon: HeroIcon(
          HeroIcons.signalSlash,
          color: Colors.red,
          size: 30,
        ),
      );
      // Get.rawSnackbar(
      //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      //   messageText: Text(
      //     "PLEASE CONNECT TO THE INTERNET",
      //     style: normalTextStyle.copyWith(
      //       fontWeight: semiBold,
      //       fontSize: 12,
      //       color: Colors.red,
      //     ),
      //   ),
      //   isDismissible: false,
      //   duration: const Duration(days: 1),
      //   backgroundColor: Colors.red[50]!,
      //   icon: const Icon(
      //     Icons.wifi_off,
      //     color: Colors.red,
      //     size: 30,
      //   ),
      //   margin: EdgeInsets.zero,
      //   snackStyle: SnackStyle.GROUNDED,
      // );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}
