import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReimbursementPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController controller;

  RxString filePath = "".obs;

  @override
  void onInit() {
    controller = TabController(length: 2, vsync: this);
    super.onInit();
  }

  RxList tipeCuti = <String>[
    "Sakit Dengan Surat Dokter",
    "Dinas Luar Kota",
    "Izin Sakit Tanpa Surat Dokter",
    "Dinas Dalam Kota",
    "Izin",
    "Cuti Menunggu Keluarga Sakit",
    "Cuti Bencana (Special Leave)",
    "Cuti Orang Tua/ Mertua Meninggal (Special Leave)",
    "Cuti Anak Meninggal (Special Leave)",
    "Cuti Menikah (Special Leave)",
    "Cuti Menikahkan Anak (Special Leave)",
    "Cuti Khitanan Anak (Special Leave)",
    "Cuti Baptis Anak (Special Leave)",
    "Cuti Istri Melahirkan atau Keguguran (Special Leave)",
    "Cuti Anggota Keluarga Dalam Satu Rumah Meninggal (Special Leave)",
  ].obs;
}
