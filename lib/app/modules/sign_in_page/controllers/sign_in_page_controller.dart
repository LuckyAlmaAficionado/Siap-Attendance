import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talenta_app/app/controllers/authentication_controller.dart';

import '../../../shared/utils.dart';

class SignInPageController extends GetxController {
  RxBool isObsecure = true.obs;

  final authC = Get.find<AuthenticationController>();

  late TextEditingController emailC;
  late TextEditingController passwordC;

  @override
  void onInit() {
    emailC = TextEditingController(text: 'superAdmin@gmail.com');
    passwordC = TextEditingController(text: 'superAdmin');
    super.onInit();
  }

  bool validatorTextField() {
    if (emailC.text.isEmpty) return true;
    if (passwordC.text.isEmpty) return true;
    return false;
  }

  Future login() async {
    // membuat validator textfield untuk menghindari kesalahan
    if (validatorTextField()) {
      Utils().snackbarC("Oh Tidak..!", "email atau password kosong..!", false);
      return;
    }

    await authC.signIn(emailC.text, passwordC.text);
  }
}
