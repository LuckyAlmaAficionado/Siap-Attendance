// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:talenta_app/app/modules/daftar_absensi_page/views/absensi_page_view.dart';
import 'package:talenta_app/app/modules/daftar_absensi_page/views/riwayat_page_view.dart';
import 'package:talenta_app/app/modules/daftar_absensi_page/views/shift_page_view%20copy.dart';
import 'package:talenta_app/app/shared/theme.dart';

import '../controllers/daftar_absensi_page_controller.dart';

class DaftarAbsensiPageView extends GetView<DaftarAbsensiPageController> {
  var listTabs = [
    RiwayatPageView(),
  ].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Absensi', style: appBarTextStyle),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TabBar(
            controller: controller.controller,
            tabs: [
              Tab(text: "Riwayat"),
              Tab(text: "Absensi"),
              Tab(text: "Shift"),
            ],
            unselectedLabelColor: darkGreyColor,
            labelColor: blueColor,
            labelStyle: normalTextStyle.copyWith(fontWeight: regular),
          ),
          Expanded(
            child: TabBarView(
              controller: controller.controller,
              children: [
                RiwayatPageView(),
                AbsensiPageView(),
                ShiftPageView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
