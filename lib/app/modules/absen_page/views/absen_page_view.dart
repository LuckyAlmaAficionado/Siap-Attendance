import 'package:flutter/material.dart';

import 'package:flutter_boxicons/flutter_boxicons.dart';
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
          elevation: 0.5,
          shadowColor: Colors.grey.shade300,
          backgroundColor: whiteColor,
          title: Text(
            'Absen',
            style: appBarTextStyle.copyWith(color: blackColor),
          ),
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
                    color: blackColor,
                  ),
                ),
                const Gap(5),
                Text(
                  '${DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now())}',
                  style: normalTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                    color: blackColor,
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
          iconTheme: IconThemeData(color: blackColor),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    if (controller.m.ci.value.id != null)
                      ListTileAbsen(
                        controller: controller,
                        colors: Colors.green.shade50,
                        type: controller.m.ci.value.type!,
                        onTap: () => Get.to(
                          () => DetailClockInView(),
                          arguments: controller.m.ci.value,
                          transition: Transition.cupertino,
                        ),
                      ),
                    const Gap(10),
                    if (controller.m.co.value.id != null)
                      ListTileAbsen(
                        controller: controller,
                        colors: Colors.red.shade50,
                        type: controller.m.co.value.type!,
                        onTap: () => Get.to(
                          () => DetailClockInView(),
                          arguments: controller.m.co.value,
                          transition: Transition.cupertino,
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class ListTileAbsen extends StatelessWidget {
  const ListTileAbsen({
    super.key,
    required this.controller,
    this.colors,
    required this.type,
    this.onTap,
  });

  final Color? colors;
  final String type;
  final Function()? onTap;
  final AbsenPageController controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(15),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        tileColor: colors,
        contentPadding: const EdgeInsets.all(15),
        title: Text(
          type,
          style: normalTextStyle.copyWith(
            fontSize: 14,
            fontWeight: semiBold,
          ),
        ),
        trailing: Icon(Boxicons.bx_chevron_right),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${DateFormat("HH:mm", "id_ID").format(controller.m.ci.value.createdAt!)}",
              style: GoogleFonts.lexend(
                fontWeight: semiBold,
                fontSize: 16,
              ),
            ),
            Text(
              "${DateFormat("dd MMM", "id_ID").format(controller.m.ci.value.createdAt!)}",
              style: normalTextStyle.copyWith(
                color: Colors.green,
                fontWeight: semiBold,
                fontSize: 14,
              ),
            )
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
