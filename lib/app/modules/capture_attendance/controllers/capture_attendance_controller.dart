import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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

  Future<XFile?> compress(File file) async {
    return await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      file.path + "${file.lengthSync()}.jpg",
      quality: 40,
    );
  }

  Future capturePicture() async {
    XFile? picture = await camController.takePicture();

    if (picture.path.isNotEmpty) {
      return File(picture.path);
    }
  }

  Future<void> onSubmitButton(String status) async {
    File picture = File((await compress(await capturePicture()))!.path);

    log("status: $status");

    switch (status) {
      case "argument-izin":
        await a.permitApplication(noteC.text, picture);
        break;
      case "argument-telat":
        await a.approvalRequest(noteC.text);
        break;
      default:
        await a.submitAttendance(noteC.text, picture);
        break;
    }
  }
}
