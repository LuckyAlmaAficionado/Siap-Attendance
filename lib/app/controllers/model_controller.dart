import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:talenta_app/app/models/karyawan.dart';
import 'package:talenta_app/app/models/model_izin.dart';
import 'package:talenta_app/app/models/user_absensi.dart';
import 'package:talenta_app/app/models/users.dart';
import 'package:talenta_app/app/shared/error_alert.dart';

import '../modules/camera_page/controllers/camera_page_controller.dart';

class ModelController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
  }

  Rx<ModelData> u = Rx<ModelData>(ModelData(token: '', user: ModelUser()));
  RxList<Karyawan> k = <Karyawan>[].obs;

  Rx<ModelAbsensi> ci = Rx<ModelAbsensi>(ModelAbsensi());
  Rx<ModelAbsensi> co = Rx<ModelAbsensi>(ModelAbsensi());

  RxList<ModelIzin> i = <ModelIzin>[].obs;
  RxList<ModelAbsensi> a = <ModelAbsensi>[].obs;

  initCamera() async {
    log("== initCamera ==");
    try {
      final camera = await availableCameras();
      final frontCamera = camera.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => camera.first,
      );

      Get.put(CameraPageController()..setCamera(frontCamera), permanent: true);
    } on CameraException catch (e) {
      Get.dialog(ErrorAlert(
        msg: e.description!,
        methodName: "initCamera | model_controller.dart",
      ));
    }
  }
}
