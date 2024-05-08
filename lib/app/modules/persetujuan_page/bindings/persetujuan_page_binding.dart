import 'package:get/get.dart';

import '../controllers/persetujuan_page_controller.dart';

class PersetujuanPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersetujuanPageController>(
      () => PersetujuanPageController(),
    );
  }
}
