import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:talenta_app/app/controllers/api_controller.dart';

import 'package:talenta_app/app/shared/loading/loading1.dart';
import 'package:talenta_app/app/shared/utils.dart';

import '../../home/views/menu_view.dart';

class AuthController extends GetxController {
  RxBool obsecure = true.obs;

  RxInt onClicked = (-1).obs;

  RxString textfield = "".obs;
  RxString tempPin = "".obs;
  RxString status = "".obs;

  final _hive = Hive.box("testBox");

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
    api.login(email, password).then((value) => (value)
        ? Get.off(() => MenuView(), transition: Transition.cupertino)
        : Utils().snackbarC("Failed", "email or password false", false));
  }

  Future saveEmailAndPassword(String email, String password) async {
    await _hive.put("email", email);
    await _hive.put("password", password);
  }

  Future checkEmailAndPassword() async {
    if (await _hive.get("email") != null &&
        await _hive.get('password') != null) {}
    return {
      "email": await _hive.get("email") ?? "",
      "password": await _hive.get("password") ?? ""
    };
  }

  Future hiveRemoveEmailAndPassword() async {
    await _hive.delete("email");
    await _hive.delete("password");
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
    await _hive.put("pin-code", value);
  }

  Future hiveRemovePin() async {
    await _hive.delete("pin-code");
  }

  Future hiveCheckPin() async {
    print(await _hive.get("pin-code"));
    return await _hive.get("pin-code");
  }

  onCheckPinValidator(String value, String status) async {
    print(this.status.value);

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
}
