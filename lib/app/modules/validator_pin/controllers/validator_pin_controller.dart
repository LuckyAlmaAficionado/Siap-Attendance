import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'dart:developer' as dev;
import 'package:talenta_app/app/routes/app_pages.dart';

import 'package:local_auth/local_auth.dart';
import '../../../shared/utils.dart';

class ValidatorPinController extends GetxController {
  /// ... controller
  TextEditingController validatorC = TextEditingController();
  LocalAuthentication localAuthentication = LocalAuthentication();
  RxBool isAvailable = false.obs;
  RxBool isAuthenticated = false.obs;
  RxString text = ''.obs;

  RxString enteredPin = "".obs;

  @override
  void onInit() {
    super.onInit();

    // .... melakukan pengecekan jika menggunakan authentication
    if (F) checkLocalAuthentication(Get.arguments ?? "signin");
  }

  checkLocalAuthentication(String status) async {
    isAvailable(await localAuthentication.canCheckBiometrics);
    if (isAvailable.value) {
      List<BiometricType> types =
          await localAuthentication.getAvailableBiometrics();
      text("Biometric Available");
      for (var item in types) {
        text.value += "\n- $item";
      }
    }

    await isLocalAuthenticationAvailable(status);
  }

  isLocalAuthenticationAvailable(String status) async {
    // ... mendapatkan data apakah user ter-autentikasi
    isAuthenticated.value = await localAuthentication.authenticate(
        localizedReason:
            "In order to use Fingerprint sensor we need your anthorization first.",
        options: AuthenticationOptions(
          stickyAuth: true,
          useErrorDialogs: true,
        ));

    // ... jika benar maka
    if (isAuthenticated.value && status.contains("signin")) {
      // Berikan loading untuk interface
      Utils().informationUtils(
        "Loading ",
        "Sedang mendapatkan data",
        false,
      );
      // Jika login maka akan langsung otomatis login
      return;
    } else if (isAuthenticated.value && status.contains("slip-gaji")) {
      Get.offNamed(Routes.SLIP_GAJI_PAGE);
      return;
    }
  }

  void checkPin(String validator) {
    if (validatorC.text == "1") {
      print("PIN is correct!");

      // Lakukan tindakan yang diperlukan setelah PIN benar
      validatorFrom(validator);
    } else {
      Utils().snackbarC("Oh Tidak..!", "PIN yang anda masukan salah!", false);
      print("PIN is incorrect!");
      // Lakukan tindakan yang diperlukan setelah PIN salah
    }
    resetTextField();
  }

  validatorFrom(String validator) async {
    switch (validator) {
      case "non-aktif":
        dev.log("PIN dinonaktifkan");
        Get.back();
        break;
      case "aktif":
        // await authC.autoLogin();
        dev.log("validator masuk aplikasi");
        Get.toNamed(Routes.DASHBOARD_PAGE);
        break;
      case "slip-gaji":
        dev.log("masuk ke slip gaji");
        Get.offNamed(Routes.SLIP_GAJI_PAGE);
        break;
      default:
        Utils().informationUtils(
          "Loading ",
          "Mendapatkan data pengguna",
          false,
        );
        break;
    }
  }

  resetTextField() {
    validatorC.text = "";
  }
}
