import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
                  style: GoogleFonts.lexend(
                    fontSize: 30,
                    fontWeight: regular,
                    color: whiteColor,
                  ),
                ),
                const Gap(5),
                Text(
                  '${DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now())}',
                  style: normalTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                    color: whiteColor,
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "Daftar Absensi",
                      style: normalTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 14,
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
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  if (controller.m.ci.value.id != null)
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      onTap: () => Get.to(
                        DetailClockInView(),
                        arguments: controller.m.ci.value,
                      ),
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${DateFormat("HH:mm", "id_ID").format(controller.m.ci.value.createdAt!)}",
                            style: normalTextStyle.copyWith(
                              fontWeight: semiBold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "${DateFormat("dd MMM", "id_ID").format(controller.m.ci.value.createdAt!)}",
                            style: greenTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: extraLight,
                            ),
                          )
                        ],
                      ),
                      title: Text(
                        controller.m.ci.value.type!,
                        style: normalTextStyle.copyWith(
                          fontWeight: extraLight,
                          fontSize: 14,
                        ),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    ),
                  if (controller.m.co.value.id != null)
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      onTap: () {
                        Get.to(
                          DetailClockInView(),
                          arguments: controller.m.co.value,
                        );
                      },
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${DateFormat("HH:mm", "id_ID").format(controller.m.co.value.createdAt!)}",
                            style: normalTextStyle.copyWith(
                              fontWeight: semiBold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "${DateFormat("dd MMM", "id_ID").format(controller.m.co.value.createdAt!)}",
                            style: greenTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: extraLight,
                            ),
                          )
                        ],
                      ),
                      title: Text(
                        controller.m.co.value.type!,
                        style: normalTextStyle.copyWith(
                          fontWeight: extraLight,
                          fontSize: 14,
                        ),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    ),
                ],
              )
            ],
          ),
        ));
  }
}
