import 'package:get/get.dart';

import '../controllers/slip_gaji_page_controller.dart';

class SlipGajiPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SlipGajiPageController>(
      () => SlipGajiPageController(),
    );
  }
}
