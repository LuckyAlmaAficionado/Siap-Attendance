import 'dart:async';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:talenta_app/app/controllers/api_controller.dart';
import 'package:talenta_app/app/controllers/locations_controller.dart';
import 'package:talenta_app/app/models/locations.dart';

import '../../../shared/alert/alert-out-range.dart';
import '../../capture_attendance/views/capture_attendance_view.dart';

class LocationsPageController extends GetxController {
  final locations = Get.put(LocationController());
  final a = Get.put(ApiController());

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

  Future checkCurrentLocation(String status) async {
    // Module lokasi dalam range atau tidak
    double latitude = 0.0;
    double longitude = 0.0;

    // Todo: BUAT VALIDASI UNTUK CEK LOKASI LIST
    List<ModelLocations> validator = await a.getLocations();

    latitude = this.position!.latitude;
    longitude = this.position!.longitude;

    log("validator: $validator");
    log("latitude: $latitude");
    log("longitude: $longitude");

    bool isFlexible = false;
    validator.forEach((element) {
      if (element.flexible == 1) {
        isFlexible = true;
      }
    });

    if (!isFlexible) {
      List<ModelLocations> result = validator
          .where((element) => locations.isWithinRange(
                latitude,
                longitude,
                double.parse(element.lat),
                double.parse(element.lng),
                element.radius.toDouble(),
              ))
          .toList();

      if (result.isEmpty) {
        await Get.dialog(AlertOutRange(status: status));
        return;
      }
    }

    Get.to(
      () => CaptureAttendanceView(),
      transition: Transition.cupertino,
      arguments: status,
    );
  }

  @override
  void onClose() {
    isStreamEnable(false);
    _locationStreamController.close();
    super.onClose();
  }
}
