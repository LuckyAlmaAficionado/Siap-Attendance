import 'package:get/get.dart';
import 'package:talenta_app/app/models/karyawan.dart';

class DetailKaryawanController extends GetxController {
  late Karyawan karyawan;

  @override
  void onInit() {
    super.onInit();
    karyawan = Get.arguments as Karyawan;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
