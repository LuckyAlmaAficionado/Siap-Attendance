// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:talenta_app/app/controllers/authentication_controller.dart';
import 'package:talenta_app/app/models/users.dart';
import 'package:talenta_app/app/shared/theme.dart';

import 'info_personal_page_view.dart';

class InfoPekerjaanView extends GetView {
  InfoPekerjaanView({Key? key}) : super(key: key);

  Data data = Get.find<AuthenticationController>().data.value!.data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Info pekerjaan',
          style: appBarTextStyle,
        ),
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
            subTitle: "${data.user.id}",
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
            subTitle: "${data.divisi}",
          ),
          InfoPersonalTile(
            title: "Posisi Pekerjaan",
            subTitle: "${data.jabatan}",
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
            subTitle: "0 Year 0 Month 3 Day",
          ),
        ],
      ),
    );
  }
}
