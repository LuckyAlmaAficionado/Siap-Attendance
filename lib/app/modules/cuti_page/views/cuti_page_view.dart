// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import 'package:talenta_app/app/modules/cuti_page/views/delegasi_page_view.dart';
import 'package:talenta_app/app/modules/cuti_page/views/pengajuan_status_page_view.dart';
import 'package:talenta_app/app/shared/theme.dart';

import '../controllers/cuti_page_controller.dart';

class CutiPageView extends GetView<CutiPageController> {
  CutiPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cuti',
          style: appBarTextStyle.copyWith(color: blackColor),
        ),
        iconTheme: IconThemeData(color: blackColor),
        centerTitle: true,
        backgroundColor: whiteColor,
      ),
      body: Column(
        children: [
          Material(
            elevation: 3,
            child: Container(
              width: Get.width,
              height: 170,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 90,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: darkGreyColor),
                    ),
                    child: (false)
                        ? SizedBox()
                        : Center(
                            child: Text(
                              "Tidak ada data cuti",
                              style: normalTextStyle.copyWith(
                                fontWeight: medium,
                                fontSize: 14,
                              ),
                            ),
                          ),
                  ),
                  const Gap(10),
                  TabBar(
                    controller: controller.controller,
                    unselectedLabelColor: darkGreyColor,
                    labelStyle: normalTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 13,
                    ),
                    tabs: [
                      Tab(child: Text("Pengajuan")),
                      Tab(child: Text("Delegasi"))
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: TabBarView(
              controller: controller.controller,
              children: [
                PengajuanStatusPageView(),
                DelegasiPageView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
