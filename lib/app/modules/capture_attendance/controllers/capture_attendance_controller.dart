import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import 'package:talenta_app/app/controllers/api_controller.dart';
import 'package:uuid/uuid.dart';

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

  Future<File> _saveImage(File image) async {
    var uuid = Uuid();

    final directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;
    final String fileName = "${uuid.v1()}.jpg";
    final File localImage = await image.copy('$path/$fileName');
    print("Gambar disimpan di: ${localImage.path}");

    return localImage;
  }

  Future<dynamic> loadImage(String name) async {
    if (name.contains("/")) {
      name = name.split("/").last;
    }

    print("name: $name");

    final directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;

    final String fileName = "$name"; // Nama file yang diinginkan
    final File localImage = File('$path/$fileName');

    if (await localImage.exists()) {
      return localImage;
    }
    return null;
  }

  Future<void> onSubmitButton(String status) async {
    File picture = File((await compress(await capturePicture()))!.path);

    File localImage = await _saveImage(picture); // save image to fileSystem

    log("status: $status");
    log(localImage.path.split("/").last);

    switch (status) {
      case "argument-izin":
        await a.permitApplication(noteC.text, localImage);
        break;
      case "argument-telat":
        await a.approvalRequest(noteC.text);
        break;
      default:
        await a.submitAttendance(noteC.text, localImage);
        break;
    }
  }
}
