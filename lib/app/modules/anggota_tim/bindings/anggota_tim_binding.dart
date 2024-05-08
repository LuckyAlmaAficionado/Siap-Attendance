import 'package:get/get.dart';

import '../controllers/anggota_tim_controller.dart';

class AnggotaTimBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnggotaTimController>(
      () => AnggotaTimController(),
    );
  }
}
