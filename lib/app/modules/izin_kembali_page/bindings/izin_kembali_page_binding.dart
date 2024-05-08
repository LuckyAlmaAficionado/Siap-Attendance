import 'package:get/get.dart';

import '../controllers/izin_kembali_page_controller.dart';

class IzinKembaliPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IzinKembaliPageController>(
      () => IzinKembaliPageController(),
    );
  }
}
