import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:talenta_app/app/controllers/model_controller.dart';
import 'package:talenta_app/app/modules/akun_services/info_saya/info_personal_page_view.dart';
import 'package:talenta_app/app/shared/theme.dart';

// ignore: must_be_immutable
class InfoPekerjaanView extends GetView {
  InfoPekerjaanView({Key? key}) : super(key: key);

  final m = Get.find<ModelController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info pekerjaan', style: appBarTextStyle),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
        ),
        children: [
          InfoPersonalTile(
            title: "ID Karyawan",
            subTitle: "${m.u.value.user.id}",
          ),
          InfoPersonalTile(
            title: "Barcode",
            subTitle: "3030",
          ),
          InfoPersonalTile(
            title: "Nama Perusahaan",
            subTitle: "Andi Offset",
          ),
          InfoPersonalTile(
            title: "Cabang",
            subTitle: "CV Andi Offset Yogyakarta Pusat",
          ),
          InfoPersonalTile(
            title: "Nama Organisasi",
            subTitle: "${m.u.value.divisi}",
          ),
          InfoPersonalTile(
            title: "Posisi Pekerjaan",
            subTitle: "${m.u.value.user.nama}",
          ),
          InfoPersonalTile(
            title: "Level Pekerjaan",
            subTitle: "Staff",
          ),
          InfoPersonalTile(
            title: "Status Pekerjaan",
            subTitle: "Contract",
          ),
          InfoPersonalTile(
            title: "Tanggal Bergabung",
            subTitle: "18 Mar 2023",
          ),
          InfoPersonalTile(
            title: "Masa Berakhir Kontrak",
            subTitle: "18 Jun 2024",
          ),
          InfoPersonalTile(
            title: "Masa Kerja",
            subTitle: "${yearsOfService()}",
          ),
        ],
      ),
    );
  }

  yearsOfService() {
    DateTime firstTime = DateTime(2024, 3, 19).toLocal();
    DateTime secondTime = DateTime.now().toLocal();

    Duration difference = secondTime.difference(firstTime);

    int totalDays = difference.inDays;
    int years = totalDays ~/ 365;
    int remainingDaysAfterYears = totalDays % 365;
    int months = remainingDaysAfterYears ~/ 30;
    int days = remainingDaysAfterYears % 30;

    return "$years Tahun $months Bulan $days Hari";
  }
}
