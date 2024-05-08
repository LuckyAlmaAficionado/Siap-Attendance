import 'package:get/get.dart';

import '../controllers/reimbursement_page_controller.dart';

class ReimbursementPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReimbursementPageController>(
      () => ReimbursementPageController(),
    );
  }
}
