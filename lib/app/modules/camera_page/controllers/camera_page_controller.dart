import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
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

  Future<void> onPressButton() async {
    if (!cameraC.value.isInitialized) return;

    try {
      imgPath((await cameraC.takePicture()).path);
      File img = File((await compress(File(imgPath.value)))!.path);

      status == "argument-izin"
          ? await a.permitApplication(note.text, img)
          : await a.attendance(note.text, img);
    } catch (e) {
      Get.dialog(ErrorAlert(
        msg: e.toString(),
        methodName: "onPressButton | camera_page_controller.dart",
      ));
    }
  }

  // Future<void> sendIzinToDatabase() async {
  //   File imgComp = File((await compress(File(imgPath.value)))!.path);

  //   try {
  //     final url = Uri.parse("$BASE_URL/api/izin");
  //     var req = http.MultipartRequest("POST", url);

  //     req.files.add(await http.MultipartFile.fromPath("image", imgComp.path));

  //     Position p = await getCurrentLocation();

  //     req.fields['user_id'] = m.u.value.user.id!;
  //     req.fields['alasan'] = note.text;
  //     req.fields['latitude'] = p.latitude.toString();
  //     req.fields['longitude'] = p.longitude.toString();

  //     var res = await req.send();

  //     if (res.statusCode == 200) {
  //       Get.back();
  //       Get.off(() => MenuView(), transition: Transition.cupertino);
  //     }
  //   } catch (e) {
  //     Get.dialog(ErrorAlert(
  //       msg: e.toString(),
  //       methodName: "sendIzinToDatabase | camera_page_controller.dart",
  //     ));
  //   }
  // }

  // Future<void> sendImageToDatabase() async {
  //   File imgCompress = File((await compress(File(imgPath.value)))!.path);

  //   try {
  //     final apiUrl = Uri.parse("$BASE_URL/api/v1/user-absensi");

  //     var req = http.MultipartRequest("POST", apiUrl);

  //     req.files.add(await http.MultipartFile.fromPath(
  //       "image",
  //       imgCompress.path,
  //     ));

  //     req.headers.addAll({"Authorization": "Bearer ${m.u.value.token}"});

  //     // Get location
  //     Position pos = await getCurrentLocation();

  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //       pos.latitude,
  //       pos.longitude,
  //     );

  //     Placemark placemark = placemarks.first;
  //     String address =
  //         '${placemark.street}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}';

  //     String userId = m.u.value.user.id!;

  //     req.fields['user_absensi_id'] = userId;
  //     req.fields['lang'] = pos.longitude.toString();
  //     req.fields['lat'] = pos.latitude.toString();
  //     req.fields['address'] = address;
  //     req.fields['catatan'] = note.text.isEmpty ? "-" : note.text;

  //     var res = await req.send();

  //     print(res.statusCode);

  //     if (res.statusCode == 200) {
  //       await a.fetchTodayAttendance();
  //       await a.fetchPermitByUserId();

  //       Get.back();
  //       await Get.to(DetailAbsenView(status: true));
  //     } else {
  //       Get.back();
  //       Get.to(DetailAbsenView(status: false));
  //     }
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
}
