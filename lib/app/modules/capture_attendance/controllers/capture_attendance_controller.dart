import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talenta_app/app/controllers/api_controller.dart';

class CaptureAttendanceController extends GetxController {
  RxList<CameraDescription> cameras = <CameraDescription>[].obs;
  TextEditingController noteC = TextEditingController();
  late CameraController camController;

  final a = Get.put(ApiController());

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future capturePicture() async {
    XFile? picture = await camController.takePicture();

    if (picture.path.isNotEmpty) {
      return File(picture.path);
    }
  }

  Future<void> onSubmitButton(String status) async {
    File picture = await capturePicture();

    log("status: $status");

    switch (status) {
      case "argument-izin":
        // Argument izin ...
        a.permitApplication(noteC.text, picture);

        break;
      case "argument-telat":
        // Argument Telat ...

        break;
      default:
        // Default argument ...

        break;
    }
  }
}
