import 'package:get/get.dart';

import 'package:talenta_app/app/controllers/authentication_controller.dart';
import 'package:talenta_app/app/models/users.dart';

class SlipGajiPageController extends GetxController {
  ModelData data = Get.find<AuthenticationController>().data.value!.data;
}
