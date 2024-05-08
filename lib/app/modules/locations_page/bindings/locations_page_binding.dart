import 'package:get/get.dart';

import '../controllers/locations_page_controller.dart';

class LocationsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationsPageController>(
      () => LocationsPageController(),
    );
  }
}
