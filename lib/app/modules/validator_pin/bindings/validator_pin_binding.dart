import 'package:get/get.dart';

import '../controllers/validator_pin_controller.dart';

class ValidatorPinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ValidatorPinController>(
      () => ValidatorPinController(),
    );
  }
}
