import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:talenta_app/app/controllers/api_controller.dart';

import 'package:talenta_app/app/controllers/model_controller.dart';
import 'package:talenta_app/app/models/users.dart';

import '../../../controllers/version_controller.dart';
import '../../../models/karyawan.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/apps_version_failed.dart';
import '../../../shared/utils.dart';

class HomeController extends GetxController {
  final versionC = Get.put(VersionController());

  RxList<Karyawan> sortingKaryawan = <Karyawan>[].obs;
  RxList<Karyawan> karyawan = Get.find<ModelController>().k;

  RxInt btmNavIndex = 0.obs;
  RxBool isIzin = false.obs;

  late bool isManager = false;

  ModelData u = Get.find<ModelController>().u.value;
  final m = Get.put(ModelController());
  final a = Get.put(ApiController());

  @override
  void onInit() async {
    super.onInit();
    await validatorIzin();

    if (u.user.manager == "1") await a.fetchAllEmployee();

    String curVersion = await versionC.androidAppsVersion();
    if (curVersion != "1.1.7") {
      Get.dialog(AppsVersionFailed());
    }
  }

  // Asynchronous function to validate a permission for a user. Returns a boolean value based on the validation result.
  Future validatorIzin() async {
    log("validatorIzin");
    var res = await http.get(Uri.parse("${a.BASE_URL}/api/izin/${u.user.id}"));

    if (res.statusCode == 200) {
      isIzin(bool.parse(res.body));
      return isIzin.value;
    }
  }

  clockInAbsensi() async {
    if (m.ci.value.id != null) {
      Utils().informationUtils("Informasi", "Anda sudah absen Clock-In", true);
    } else {
      Get.toNamed(Routes.LOCATIONS_PAGE, arguments: "clockin");
    }
  }

  clockOutAbsensi() async {
    if (m.ci.value.id == null) {
      Utils().informationUtils("Informasi", "Kamu belum absen clock-in", true);
    } else if (m.co.value.id != null) {
      Utils().informationUtils("Informasi", "Anda sudah absen Clock-Out", true);
    } else {
      Get.toNamed(Routes.LOCATIONS_PAGE, arguments: "clockout");
    }
  }

  void changeBtmNavIndex(int index) => btmNavIndex(index);

  Future onRefresh() async {
    await a.fetchTodayAttendance();
    await a.fetchDetailAttendance();
    await validatorIzin();
  }
}
