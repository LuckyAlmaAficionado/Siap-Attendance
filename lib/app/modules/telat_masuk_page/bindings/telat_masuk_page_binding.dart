import 'package:get/get.dart';

import '../controllers/telat_masuk_page_controller.dart';

class TelatMasukPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TelatMasukPageController>(
      () => TelatMasukPageController(),
    );
  }
}
