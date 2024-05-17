import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:talenta_app/app/controllers/api_controller.dart';
import 'package:talenta_app/app/shared/error_alert.dart';
import 'package:talenta_app/app/shared/loading/loading1.dart';
import 'package:talenta_app/app/shared/utils.dart';

import '../../home/views/menu_view.dart';

class AuthController extends GetxController {
  RxBool obsecure = true.obs;

  RxInt onClicked = (-1).obs;

  RxString textfield = "".obs;
  RxString tempPin = "".obs;
  RxString status = "".obs;

  final sp = SharedPreferences.getInstance();

  TextEditingController email = TextEditingController(
    text: "superAdmin@gmail.com",
  );
  TextEditingController password = TextEditingController(
    text: "superAdmin",
  );

  // === controller
  final api = Get.put(ApiController());

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onClose() async {
    email.dispose();
    password.dispose();
    super.onClose();
  }

  // ============= HIVE ACCOUNT ===============

  Future login(String email, String password) async {
    await api.login(email, password).then((value) => (value)
        ? Get.off(() => MenuView(), transition: Transition.cupertino)
        : Utils().snackbarC("Failed", "email or password false", false));
  }

  Future saveEmailAndPassword(String email, String password) async {
    SharedPreferences sps = await sp;
    sps.setString("email", email);
    sps.setString("password", password);
  }

  Future checkEmailAndPassword() async {
    SharedPreferences sps = await sp;

    String email = sps.get("email").toString();
    String password = sps.get("password").toString();

    if (email.isNotEmpty && password.isNotEmpty) {
      return login(email, password).then((value) => {
            "email": email,
            "password": password,
          });
    }

    return {"email": "", "password": ""};
  }

  Future hiveRemoveEmailAndPassword() async {
    SharedPreferences sps = await sp;

    sps.remove("email");
    sps.remove("password");

    await hiveRemovePin();
  }

  // ============ HIVE PIN =====================

  Future initHive() async {
    String pin_code = await hiveCheckPin();

    if (pin_code.isEmpty) {
      status("Buat PIN Baru Anda");
    } else if (pin_code.isNotEmpty) {
      status("Masukan PIN Anda");
    }
  }

  Future hiveSetPin(String value) async {
    SharedPreferences sps = await sp;
    sps.setString("pin-code", value);
  }

  Future hiveRemovePin() async {
    SharedPreferences sps = await sp;
    sps.remove("pin-code");
  }

  Future hiveCheckPin() async {
    SharedPreferences sps = await sp;
    return sps.get("pin-code");
  }

  onCheckPinValidator(String value, String status) async {
    if (status == "remove-pin-code") {
      print("remove-pin-code");
      await hiveRemovePin();
      Get.off(() => MenuView());
    }

    if (status == "login") {
      Get.dialog(Loading1());
      String pin = await hiveCheckPin();
      Get.back();
      (pin == value)
          ? Get.snackbar("Succes...!", "Login successfuly")
          : Get.snackbar('Failed..!', "Pin required");
    }

    if (status == "set-password") {
      if (tempPin.isNotEmpty) {
        if (tempPin == value) {
          hiveSetPin(value);
          Get.off(() => MenuView(), transition: Transition.cupertino);
        } else {
          print("pin tidak sama");
        }
      } else {
        tempPin(value);
      }
    }

    tempPin("");
  }

  Future hiveAutoLogin() async {
    SharedPreferences sps = await sp;
    try {
      String email = sps.get("email").toString();
      String password = sps.get("password").toString();
      if (email.isNotEmpty && password.isNotEmpty) {
        // Jika password dan email tidak kosong
      }
    } on Exception catch (e) {
      Get.dialog(ErrorAlert(
        msg: e.toString(),
        methodName: "hiveAutoLogin | authentication_controller",
      ));
    }
  }
}
