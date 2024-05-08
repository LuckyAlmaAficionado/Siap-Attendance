import 'package:get/get.dart';

import '../controllers/absen_page_controller.dart';

class AbsenPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AbsenPageController>(
      () => AbsenPageController(),
    );
  }
}
