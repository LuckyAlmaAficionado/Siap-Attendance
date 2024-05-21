import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:talenta_app/app/controllers/locations_controller.dart';
import 'package:talenta_app/app/routes/app_pages.dart';
import 'package:talenta_app/app/shared/alert/alert-out-range.dart';

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

  Future checkCurrentLocation(String status) async {
    // Module lokasi dalam range atau tidak
    final result = locations.isWithinRange(
      this.position!.latitude,
      this.position!.longitude,
      -7.774941,
      110.395375,
      50,
    );

    if (!result) {
      await Get.dialog(AlertOutRange());
      return;
    }

    Get.toNamed(Routes.CAMERA_PAGE, arguments: status);
  }

  @override
  void onClose() {
    isStreamEnable(false);
    _locationStreamController.close();
    super.onClose();
  }
}
