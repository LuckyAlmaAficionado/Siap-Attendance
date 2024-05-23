import 'package:get/get.dart';

import '../controllers/capture_attendance_controller.dart';

class CaptureAttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CaptureAttendanceController>(
      () => CaptureAttendanceController(),
    );
  }
}
