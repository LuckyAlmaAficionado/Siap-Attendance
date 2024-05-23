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
        elevation: 0,
        backgroundColor: whiteColor,
        title: Text(
          'Daftar Absensi',
          style: appBarTextStyle.copyWith(
            color: blackColor,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: blackColor),
      ),
      body: Column(
        children: [
          Material(
            color: whiteColor,
            elevation: 2,
            child: TabBar(
              controller: controller.controller,
              tabs: [
                Tab(text: "Riwayat"),
                Tab(text: "Absensi"),
                Tab(text: "Shift"),
              ],
              labelStyle: normalTextStyle.copyWith(fontWeight: regular),
              unselectedLabelColor: darkGreyColor,
              labelColor: blueColor,
            ),
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
