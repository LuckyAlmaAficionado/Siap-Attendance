import 'package:get/get.dart';

import '../controllers/daftar_absensi_page_controller.dart';

class DaftarAbsensiPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DaftarAbsensiPageController>(
      () => DaftarAbsensiPageController(),
    );
  }
}
