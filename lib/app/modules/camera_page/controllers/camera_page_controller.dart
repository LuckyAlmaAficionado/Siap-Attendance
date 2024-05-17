import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';

import 'package:talenta_app/app/controllers/api_controller.dart';
import 'package:talenta_app/app/controllers/model_controller.dart';
import 'package:talenta_app/app/shared/error_alert.dart';

class CameraPageController extends GetxController {
  TextEditingController note = TextEditingController();
  late Future<void> initializeControllerFuture;
  late CameraDescription _camera;
  late CameraController cameraC;

  final m = Get.find<ModelController>();
  final a = Get.put(ApiController());

  RxString imgPath = "".obs;
  CameraDescription get camera => _camera;

  late String status;

  @override
  void onInit() {
    super.onInit();
    cameraC = CameraController(camera, ResolutionPreset.max);
    initializeControllerFuture = cameraC.initialize();
  }

  void setCamera(CameraDescription camera) {
    _camera = camera;
    update(); // Update state
  }

  Future<XFile?> compress(File file) async =>
      await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        file.path + "${file.lengthSync()}.jpg",
        quality: 40,
      );

  Future<void> onPressButton(String s) async {
    if (!cameraC.value.isInitialized) return;

    try {
      XFile p = await cameraC.takePicture();

      imgPath(p.path);
      File img = File((await compress(File(p.path)))!.path);

      if (s == "argument-izin") {
        print("masuk ke izin");
        await a.permitApplication(note.text, img);
      } else {
        print("masuk ke absen");
        await a.submitAttendance(note.text, img);
      }

      status = "";
    } catch (e) {
      Get.dialog(ErrorAlert(
        msg: e.toString(),
        methodName: "onPressButton | camera_page_controller.dart",
      ));
    }
  }
}
