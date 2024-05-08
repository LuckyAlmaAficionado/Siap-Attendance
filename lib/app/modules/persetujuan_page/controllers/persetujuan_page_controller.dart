import 'package:get/get.dart';

class PersetujuanPageController extends GetxController {
  RxString persetujuan = "".obs;

  @override
  void onInit() {
    super.onInit();
    persetujuan.value = Get.arguments;
  }
}
