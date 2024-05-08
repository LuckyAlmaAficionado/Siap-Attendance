import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:talenta_app/app/routes/app_pages.dart';
import 'package:talenta_app/app/shared/theme.dart';

import '../controllers/absen_page_controller.dart';

import 'detail_clock_in_view.dart';

class AbsenPageView extends GetView<AbsenPageController> {
  const AbsenPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Absen', style: appBarTextStyle),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(Get.height * 0.11),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${DateFormat("HH:mm", "id_ID").format(DateTime.now())}',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: semiBold,
                    color: whiteColor,
                  ),
                ),
                Text(
                  '${DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now())}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: semiBold,
                    color: whiteColor,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: ListView(
            children: [
              Row(
                children: [
                  Text(
                    "Daftar absensi",
                    style: blackTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 16,
                    ),
                  ),
                  new Spacer(),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.DAFTAR_ABSENSI_PAGE),
                    child: Text(
                      "Lihat Log",
                      style: blueTextStyle.copyWith(
                        fontWeight: regular,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  if (controller.authC.clockInEntry.value != null)
                    ListTile(
                      onTap: () => Get.to(
                        DetailClockInView(),
                        arguments: controller.authC.clockInEntry,
                      ),
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${DateFormat("HH:mm", "id_ID").format(controller.authC.clockInEntry.value!.createdAt!)}",
                            style: blackTextStyle.copyWith(
                              fontWeight: semiBold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "${DateFormat("dd MMM", "id_ID").format(controller.authC.clockInEntry.value!.createdAt!)}",
                            style: greenTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: extraLight,
                            ),
                          )
                        ],
                      ),
                      title: Text(
                        controller.authC.clockInEntry.value!.type!,
                        style: blackTextStyle.copyWith(
                          fontWeight: extraLight,
                          fontSize: 14,
                        ),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    ),
                  if (controller.authC.clockOutEntry.value != null)
                    ListTile(
                      onTap: () {
                        print(controller.authC.clockOutEntry.value!.createdAt);
                        Get.to(
                          DetailClockInView(),
                          arguments: controller.authC.clockOutEntry,
                        );
                      },
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${DateFormat("HH:mm", "id_ID").format(controller.authC.clockOutEntry.value!.createdAt!)}",
                            style: blackTextStyle.copyWith(
                              fontWeight: semiBold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "${DateFormat("dd MMM", "id_ID").format(controller.authC.clockOutEntry.value!.createdAt!)}",
                            style: greenTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: extraLight,
                            ),
                          )
                        ],
                      ),
                      title: Text(
                        controller.authC.clockOutEntry.value!.type!,
                        style: blackTextStyle.copyWith(
                          fontWeight: extraLight,
                          fontSize: 14,
                        ),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    ),
                ],
              )
              // Column(
              //   children: List.generate(3, (index) {
              //     return
              //   }).toList(),
              // )
            ],
          ),
        ));
  }
}
