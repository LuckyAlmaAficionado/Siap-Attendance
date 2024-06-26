import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:talenta_app/app/controllers/api_controller.dart';

import 'package:talenta_app/app/controllers/locations_controller.dart';
import 'package:talenta_app/app/routes/app_pages.dart';

class TelatMasukPageController extends GetxController {
  RxInt rentangWaktu = 0.obs;
  RxString timePicker = "".obs;
  RxString latitude = "".obs;
  RxString longitude = "".obs;

  final locationC = Get.put(LocationController());
  final a = Get.put(ApiController());

  @override
  void onInit() async {
    super.onInit();
  }

  submitAction() async {
    Get.toNamed(Routes.LOCATIONS_PAGE, arguments: "argument-telat");
  }

  fetchCurrentLocation() async {
    Position position = await locationC.getCurrentLocation();
    latitude(position.latitude.toString());
    longitude(position.longitude.toString());
  }

  calculateLateMinutes(TimeOfDay inputTime) async {
    // Mendapatkan waktu istirahat (12:45) dalam bentuk TimeOfDay
    final TimeOfDay restTime = TimeOfDay(hour: 12, minute: 45);

    final TimeOfDay lateTime = inputTime;

    // Menghitung selisih waktu dalam menit
    int lateMinutes = lateTime.hour * 60 +
        lateTime.minute -
        (restTime.hour * 60 + restTime.minute);

    // Jika terlambat, pastikan nilai menit tidak kurang dari 0
    if (lateMinutes < 0) {
      lateMinutes = 0;
    }

    return lateMinutes;
  }
}
