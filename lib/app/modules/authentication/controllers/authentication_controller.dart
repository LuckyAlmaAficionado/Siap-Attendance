import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:talenta_app/app/controllers/api_controller.dart';
import 'package:talenta_app/app/controllers/model_controller.dart';
import 'package:talenta_app/app/shared/theme.dart';
import 'package:talenta_app/app/shared/utils.dart';

import '../../../controllers/calendar_controller.dart';
import '../../../controllers/connection_controller.dart';
import '../../home/views/menu_view.dart';

class AuthController extends GetxController {
  RxBool obsecure = true.obs;

  RxInt onClicked = (-1).obs;

  RxString textfield = "".obs;
  RxString tempPin = "".obs;
  RxString status = "".obs;

  RxString informations = "Masukan PIN Anda".obs;

  final a = Get.put(ApiController());
  final m = Get.find<ModelController>();
  final connection = Get.put(ConnectionController());

  TextEditingController email = TextEditingController(
    text: "superAdmin@gmail.com",
  );
  TextEditingController password = TextEditingController(
    text: "superAdmin",
  );

  final _box = Hive.box("siap");

  // === controller
  late final ApiController api;

  @override
  void onInit() async {
    api = Get.put(ApiController());
    super.onInit();
  }

  @override
  void onClose() async {
    super.onClose();
  }

  // ============= HIVE ACCOUNT ===============

  Future login(String email, String password) async {
    // Get.dialog(
    //   barrierDismissible: false,
    //   Center(child: CircularProgressIndicator()),
    // );

    await pinValidator();
    await api.login(email, password).then((value) async => (value)
        ? {
            await saveEmailAndPassword(email, password),
            await a.fetchShifts(),
            await a.fetchDetailAttendance(),
            CalendarController().checkDateStatus(DateTime.now()),
            // Get.back(),
            if (m.pinC.isEmpty)
              {
                Get.off(() => MenuView(), transition: Transition.cupertino),
              }
          }
        : {
            Get.back(),
            Utils().snackbarC("Failed", "email or password false", false),
          });
  }

  Future saveEmailAndPassword(String email, String password) async {
    log('=== saveEmailAndPassword ===');
    _box.put("email", email);
    _box.put("password", password);
  }

  Future<Map<String, dynamic>> checkEmailAndPassword() async {
    log("=== check email and password ===");

    String? email = _box.get("email");
    String? password = _box.get("password");

    if (email != null &&
        email.isNotEmpty &&
        password != null &&
        password.isNotEmpty) {
      await a.fetchShifts();
      await a.fetchDetailAttendance();
      CalendarController().checkDateStatus(DateTime.now());
      await saveEmailAndPassword(email, password);
      return login(email, password).then((value) => {
            "email": email,
            "password": password,
          });
    }

    log("=== auto login false ===");
    return {
      "email": null,
      "password": null,
    };
  }

  // hive

  Future removeAllHive() async {
    if (m.pinC.value == textfield.value) {
      await m.pinC("");
      await _box.delete("pin-code");
      Get.back();
    } else {
      informations("PIN Tidak Sesuai");
    }
  }

  Future<String?> pinValidator() async {
    String? pin = await _box.get("pin-code");
    m.pinC(pin);
    return pin;
  }

  Future hiveRemoveEmailAndPassword() async {
    _box.deleteFromDisk();
    _box.clear();
  }

  Future saveNewPin() async {
    log("== pin saved ==");
    m.pinC(textfield.value);
    await _box.put("pin-code", textfield.value);
  }

  Future isPinTrue() async {
    String inputPin = textfield.value;
    String? curPin = await pinValidator();

    if (inputPin == curPin) {
      await checkEmailAndPassword();
      Get.off(() => MenuView(), transition: Transition.cupertino);
    } else {
      informations("PIN Tidak Sesuai");
    }
  }

  Future changePin() async {
    String inputPin = textfield.value;
    String? curPin = await pinValidator();

    if (inputPin == curPin) {
      informations("Masukan PIN Baru");
      return true;
    } else {
      informations("PIN Tidak Sesuai");
      return false;
    }
  }

  bool changePass = false;

  Future submitPinValidator(String status) async {
    log("$status");
    if (status == "login") {
      // jika sudah ada pin maka lakukan login
      await isPinTrue();
    }

    if (status == "matikan-pin") {
      await removeAllHive();
      return;
    }

    if (changePass) {
      await saveNewPin();
      // kembalikan ke halaman awal atau setting
      Get.back();
      // buatkan snackbar untuk notifikasi bahwa pin berhasil di ubah
      Get.snackbar(
        "",
        "",
        backgroundColor: Colors.green.withOpacity(0.2),
        messageText: Text(
          "PIN berhasil di ubah",
          style: normalTextStyle.copyWith(
            fontWeight: medium,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        titleText: Text(
          "Berhasil..!",
          style: normalTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 16,
          ),
        ),
      );
    }

    if (status == "ubah-pin") {
      changePass = await changePin();
    }

    if (m.pinC.isEmpty) {
      // jika belum ada pin maka buat pin
      log("create new pin");
      await saveNewPin();
      Get.back();
      Get.snackbar(
        "",
        "",
        backgroundColor: Colors.green.withOpacity(0.2),
        messageText: Text(
          "PIN berhasil dibuat",
          style: normalTextStyle.copyWith(
            fontWeight: medium,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        titleText: Text(
          "Berhasil..!",
          style: normalTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 16,
          ),
        ),
      );
    }
  }

  // Future hiveRemoveEmailAndPassword() async {
  //   _box.deleteFromDisk();
  //   _box.clear();
  //   await hiveRemovePin();
  // }

  // ============ HIVE PIN =====================

  // Future initHive() async {
  //   String pin_code = await hiveCheckPin();

  //   if (pin_code.isEmpty) {
  //     status("Buat PIN Baru Anda");
  //   } else if (pin_code.isNotEmpty) {
  //     status("Masukan PIN Anda");
  //   }
  // }

  // Future hiveSetPin(String value) async {
  //   await _box.put("pin-code", value);
  // }

  // Future hiveRemovePin() async {
  //   await _box.delete("pin-code");
  // }

  // Future hiveCheckPin() async {
  //   return _box.get("pin-code");
  // }

  // onCheckPinValidator(String value, String status) async {
  //   if (status == "remove-pin-code") {
  //     // log remove pin
  //     await hiveRemovePin();
  //     Get.off(() => MenuView());
  //   }

  //   if (status == "login") {
  //     Get.dialog(Loading1());
  //     String pin = await hiveCheckPin();
  //     Get.back();
  //     (pin == value)
  //         ? Get.snackbar("Succes...!", "Login successfuly")
  //         : Get.snackbar('Failed..!', "Pin required");
  //   }

  //   if (status == "set-password") {
  //     if (tempPin.isNotEmpty) {
  //       if (tempPin == value) {
  //         hiveSetPin(value);
  //         Get.off(() => MenuView(), transition: Transition.cupertino);
  //       } else {
  //         print("pin tidak sama");
  //       }
  //     } else {
  //       tempPin(value);
  //     }
  //   }

  //   tempPin("");
  // }

  // Future hiveAutoLogin() async {
  //   try {
  //     String email = _box.get("email");
  //     String password = _box.get("password");
  //     if (email.isNotEmpty && password.isNotEmpty) {
  //       // Jika password dan email tidak kosong
  //     }
  //   } on Exception catch (e) {
  //     Get.dialog(ErrorAlert(
  //       msg: e.toString(),
  //       methodName: "hiveAutoLogin | authentication_controller",
  //     ));
  //   }
  // }
}
