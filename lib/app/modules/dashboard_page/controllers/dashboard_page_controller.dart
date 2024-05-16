import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import 'package:talenta_app/app/controllers/authentication_controller.dart';
import 'package:talenta_app/app/controllers/version_controller.dart';
import 'package:talenta_app/app/models/karyawan.dart';
import 'package:talenta_app/app/modules/akun_services/info_saya/views/perubahan_shift_view.dart';
import 'package:talenta_app/app/routes/app_pages.dart';
import 'package:talenta_app/app/shared/apps_version_failed.dart';
import 'package:talenta_app/app/shared/error_alert.dart';
import 'package:talenta_app/app/shared/theme.dart';

import '../../../shared/utils.dart';
import '../../camera_page/controllers/camera_page_controller.dart';

class DashboardPageController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxBool isShowAlert = true.obs;
  RxBool onVersion = true.obs;

  AuthenticationController authC = Get.find<AuthenticationController>();
  final versionC = Get.put(VersionController());

  @override
  void onInit() async {
    super.onInit();

    // ...

    final camera = await availableCameras();
    final frontCamera = camera.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => camera.first,
    );

    Get.put(CameraPageController()..setCamera(frontCamera), permanent: true);

    String curVersion = await versionC.androidAppsVersion();
    print(curVersion);
    if (curVersion != "1.1.7") {
      Get.dialog(AppsVersionFailed());
    }

    if (authC.data.value!.data.user.superAdmin == "1") {
      await fetchAllKaryawan();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  RxList<Karyawan> karyawan = <Karyawan>[].obs;
  RxList<Karyawan> sortingKaryawan =
      <Karyawan>[].obs; // Variabel untuk menyimpan karyawan

  fetchAllKaryawan() async {
    print('start fetchAllKaryawan');
    try {
      final res = await http.get(
        Uri.parse(
            "https://backend-siap-production.up.railway.app/api/v1/all-users"),
        headers: {"Authorization": "Bearer ${authC.token}"},
      );

      if (res.statusCode == 200) {
        List result = json.decode(res.body);
        karyawan(result.map((e) => Karyawan.fromJson(e)).toList());
        karyawan.sort((a, b) => a.name!.compareTo(b.name!));
      }
    } catch (e) {
      Get.dialog(ErrorAlert(
        msg: e.toString(),
        methodName: "fetchAllKaryawan | dashboard_page_controller.dart",
      ));
    }
  }

  Stream<DateTime> timeStream = Stream.periodic(Duration(seconds: 1), (index) {
    return DateTime.now(); // Mengirim waktu saat ini setiap detik
  });

  menuPengajuan() {
    return AlertDialog(
      content: Container(
        width: Get.width * 0.8,
        height: Get.height * 0.4,
      ),
    );
  }

  clockInAbsensi() async {
    if (authC.clockInEntry.value != null) {
      Utils().informationUtils("Informasi", "Anda sudah absen Clock-In", true);
    } else {
      Get.toNamed(Routes.LOCATIONS_PAGE, arguments: "clockin");
    }
  }

  clockOutAbsensi() async {
    if (authC.clockInEntry.value == null) {
      Utils().informationUtils(
        "Informasi",
        "Kamu belum absen clock-in",
        true,
      );
    } else if (authC.clockOutEntry.value != null) {
      Utils().informationUtils("Informasi", "Anda sudah absen Clock-Out", true);
    } else {
      Get.toNamed(
        Routes.LOCATIONS_PAGE,
        arguments: "clockout",
      );
    }
  }

  // ...
  String timeOfDay() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat.Hm().format(now);

    // mendapatkan waktu dari jam yang di format
    int hour = int.parse(formattedTime.split(":").first);

    // Menggunakan logika sederhana untuk menentukan apakah itu pagi, siang, atau malam
    String timeOfDay;
    if (hour >= 5 && hour < 12) {
      timeOfDay = 'Pagi';
    } else if (hour >= 12 && hour < 18) {
      timeOfDay = 'Siang';
    } else {
      timeOfDay = 'Malam';
    }

    // Mengembalikan hasil
    return timeOfDay;
  }

  // ...

  void servicePengajuan(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: 320,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ajukan untuk",
                    style: blackTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.close,
                      color: darkGreyColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.CUTI_PAGE),
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Icon(
                            Iconsax.watch_status,
                            size: 30,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Cuti",
                            style: blackTextStyle.copyWith(fontSize: 14),
                          ),
                          new Spacer(),
                          Icon(Icons.keyboard_arrow_right_rounded),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.ABSEN_PAGE),
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Icon(
                            Iconsax.code,
                            size: 30,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Istirahat telat",
                            style: blackTextStyle.copyWith(
                              fontSize: 14,
                            ),
                          ),
                          new Spacer(),
                          Icon(Icons.keyboard_arrow_right_rounded),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Get.to(
                      PerubahanShiftView(),
                      transition: Transition.cupertino,
                    ),
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Icon(
                            Iconsax.timer_1,
                            size: 30,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Perubahan shift",
                            style: blackTextStyle.copyWith(fontSize: 14),
                          ),
                          new Spacer(),
                          Icon(Icons.keyboard_arrow_right_rounded),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
