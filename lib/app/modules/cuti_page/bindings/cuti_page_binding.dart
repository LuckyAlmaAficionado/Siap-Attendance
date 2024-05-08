import 'package:get/get.dart';

import '../controllers/cuti_page_controller.dart';

class CutiPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CutiPageController>(
      () => CutiPageController(),
    );
  }
}
