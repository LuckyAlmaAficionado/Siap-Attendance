import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:talenta_app/app/controllers/authentication_controller.dart';
import 'package:talenta_app/app/shared/detail_absen.dart';

class CameraPageController extends GetxController {
  TextEditingController catatanC = TextEditingController();
  late Future<void> initializeControllerFuture;
  late CameraDescription _camera;
  late CameraController cameraC;

  String BASE_URL = "https://backend-siap-production.up.railway.app";

  final authC = Get.find<AuthenticationController>();

  RxString imgPath = "".obs;

  CameraDescription get camera => _camera;

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

  Future<XFile?> compress(File file) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      file.path + "${file.lengthSync()}.jpg",
      quality: 20,
    );

    return result;
  }

  Future<Position> getCurrentLocation() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> onPressButton() async {
    if (!cameraC.value.isInitialized) return;

    try {
      imgPath((await cameraC.takePicture()).path);
      await sendImageToDatabase();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> sendImageToDatabase() async {
    File imgCompress = File((await compress(File(imgPath.value)))!.path);

    try {
      final apiUrl = Uri.parse("$BASE_URL/api/v1/user-absensi");

      var req = http.MultipartRequest("POST", apiUrl);

      req.files.add(await http.MultipartFile.fromPath(
        "image",
        imgCompress.path,
      ));

      req.headers.addAll({"Authorization": "Bearer ${authC.token}"});

      // Get location
      Position pos = await getCurrentLocation();

      List<Placemark> placemarks = await placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
      );

      Placemark placemark = placemarks.first;
      String address =
          '${placemark.street}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}';

      String userId = authC.data.value!.data.user.id!;

      req.fields['user_absensi_id'] = userId;
      req.fields['lang'] = pos.longitude.toString();
      req.fields['lat'] = pos.latitude.toString();
      req.fields['address'] = address;
      req.fields['catatan'] = catatanC.text.isEmpty ? "-" : catatanC.text;

      var res = await req.send();

      print(res.statusCode);

      if (res.statusCode == 200) {
        await authC.fetchDetailAbsensi();
        await authC.fetchDataAbsensi(userId);
        Get.back();
        Get.to(DetailAbsenView(status: true));
      } else {
        Get.back();
        Get.to(DetailAbsenView(status: false));
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
