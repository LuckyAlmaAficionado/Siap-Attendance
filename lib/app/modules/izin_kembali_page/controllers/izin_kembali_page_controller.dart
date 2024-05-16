import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:talenta_app/app/controllers/camera_data_controller.dart';
import 'package:talenta_app/app/controllers/locations_controller.dart';

class IzinKembaliPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  TextEditingController izinKembaliC = TextEditingController();

  final cameraC = Get.put(CameraDataController());
  RxString pathImg = "".obs;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  trackLocation() async {
    final locationC = Get.put(LocationController());
    Position position = await locationC.getCurrentLocation();

    // Ambil lokasi
    position.longitude;
    position.latitude;

    print(position.longitude);
    print(position.latitude);
  }

  onButtonPressed() async {
    await trackLocation();
  }
}
