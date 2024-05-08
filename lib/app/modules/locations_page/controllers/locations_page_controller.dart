import 'dart:async';

import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:talenta_app/app/controllers/locations_controller.dart';
import 'package:talenta_app/app/models/absen.dart';
import 'package:talenta_app/app/routes/app_pages.dart';
import 'package:talenta_app/app/shared/utils.dart';

import '../../../shared/theme.dart';

class LocationsPageController extends GetxController {
  final locations = Get.put(LocationController());

  RxBool isStreamEnable = false.obs;
  RxDouble turns = 0.0.obs;

  Position? position;

  @override
  void onInit() async {
    super.onInit();

    await locations.askingPermissions();
    streamCurrentLocation();
    isStreamEnable(true);
  }

  final _locationStreamController = StreamController<Position>.broadcast();

  Stream<Position> get locationStream => _locationStreamController.stream;

  void streamCurrentLocation() async {
    Geolocator.getPositionStream().listen((Position position) async {
      if (isStreamEnable.value) {
        _locationStreamController.add(position);
        this.position = position;
      }
    });
  }

  Future checkCurrentLocation() async {
    // Module lokasi dalam range atau tidak
    final result = locations.isWithinRange(
      this.position!.latitude,
      this.position!.longitude,
      -7.774941,
      110.395375,
      50,
    );

    // print("check current location: ${result}");

    if (!result) {
      await _alertDialog();
      return;
    }

    Get.toNamed(Routes.CAMERA_PAGE);
  }

  _alertDialog() => Get.dialog(
        barrierColor: Colors.grey.withOpacity(0.6),
        barrierDismissible: true,
        Center(
          child: Container(
            width: Get.width * 0.8,
            height: Get.height * 0.5,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/img_onboarding1.png',
                  ),
                ),
                DefaultTextStyle(
                  style: blueTextStyle.copyWith(
                      fontWeight: semiBold, fontSize: 22),
                  child: Text(
                    "Peringatan",
                    textAlign: TextAlign.center,
                  ),
                ),
                const Gap(5),
                DefaultTextStyle(
                  style: blackTextStyle.copyWith(
                    fontWeight: regular,
                    fontSize: 12,
                  ),
                  child: Text(
                    "Anda berada \ndiluar jangkauan",
                    textAlign: TextAlign.center,
                  ),
                ),
                const Gap(35),
                CustomButton(
                  title: 'Tetap Absen',
                  onTap: () => Get.offNamed(Routes.CAMERA_PAGE),
                ),
                const Gap(10),
                CustomButton(title: "Kembali", onTap: () => Get.back())
              ],
            ),
          ),
        ),
      );

  Future onPressButton() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      this.position!.latitude,
      this.position!.longitude,
    );

    Placemark placemark = placemarks.first;
    String address =
        '${placemark.street}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}';
    print(this.position!.latitude);
    print(this.position!.longitude);
    print(address);

    // Model absensi
    ModelAbsen model = ModelAbsen(
      statusAbsensi: "",
      latitude: this.position!.latitude,
      longitude: this.position!.longitude,
      alamat: address,
    );

    return model;
  }

  @override
  void onClose() {
    isStreamEnable(false);
    _locationStreamController.close();
    super.onClose();
  }
}
