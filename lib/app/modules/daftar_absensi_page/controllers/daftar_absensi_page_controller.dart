import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talenta_app/app/controllers/api_controller.dart';
import 'package:talenta_app/app/controllers/authentication_controller.dart';
import 'package:talenta_app/app/controllers/file_picker_controller.dart';
import 'package:talenta_app/app/controllers/model_controller.dart';

class DaftarAbsensiPageController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController controller;

  RxInt absent = 0.obs;
  RxInt lateClock = 0.obs;
  RxInt noClockIn = 0.obs;
  RxInt noClockOut = 0.obs;
  RxInt EarlyClockOut = 0.obs;
  RxString path = "".obs;

  bool compareDateAndMonth(DateTime dateTime1, DateTime dateTime2) {
    return dateTime1.day == dateTime2.day &&
        dateTime1.month == dateTime2.month &&
        dateTime1.year == dateTime2.year;
  }

  final filePickerC = Get.put(FilePickerController());
  final a = Get.put(ApiController());

  @override
  void onInit() async {
    controller = TabController(length: 3, vsync: this);
    await a.fetchDetailAttendance();
    super.onInit();
  }

  DateTime selectedDate = DateTime.now();

  late DateTime startDate;
  late DateTime endDate;

  bool checkIsHoliday(DateTime dateTime) {
    return dateTime.weekday == DateTime.saturday ||
        dateTime.weekday == DateTime.sunday;
  }

  void setNewDate() {
    // Dapatkan tanggal hari ini

    // Tentukan tanggal mulai (26 bulan lalu)
    startDate = DateTime(selectedDate.year, selectedDate.month - 1, 26);

    // Tentukan tanggal berakhir (25 bulan ini)
    print(selectedDate.day);
    if (selectedDate.day >= 26) {
      endDate = DateTime(selectedDate.year, selectedDate.month, 26);
    } else {
      endDate = DateTime(selectedDate.year, selectedDate.month, 26);
    }
  }

  int dateOfMonthLength() {
    // Hitung panjang rentang tanggal
    int hariLibur = 0;
    noClockOut.value = 0;

    final Duration dateRange = endDate.difference(startDate);
    final int dateLength = dateRange.inDays;

    for (int index = 0; index < dateLength; index++) {
      if (startDate.add(Duration(days: index)).weekday == DateTime.saturday ||
          startDate.add(Duration(days: index)).weekday == DateTime.sunday) {
        hariLibur++;
      }
    }

    absent.value = dateLength - hariLibur;
    print(absent.value);

    return dateLength;
  }

  Future<void> refreshInformation() async {
    setNewDate();
    await dateOfMonthLength();
  }

  Future<void> pengajuanDataAbsensi() async {
    path.value = await filePickerC.openFileExplorerPDF();

    if (path.value.isNotEmpty) {
      // ... jika ada file yang di ambil
      print(path.value);
      return;
    }

    // ... jika tidak ada file yang di ambil
    return;
  }
}
