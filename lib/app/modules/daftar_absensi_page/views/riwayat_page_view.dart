import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import 'package:talenta_app/app/modules/daftar_absensi_page/controllers/daftar_absensi_page_controller.dart';
import 'package:talenta_app/app/shared/theme.dart';

class RiwayatPageView extends StatefulWidget {
  const RiwayatPageView({super.key});

  @override
  State<RiwayatPageView> createState() => _RiwayatPageViewState();
}

class _RiwayatPageViewState extends State<RiwayatPageView> {
  final controller = Get.put(DaftarAbsensiPageController());

  @override
  Widget build(BuildContext context) {
    // ... hitung tanggal berakhir
    Get.find<DaftarAbsensiPageController>().setNewDate();

    // ... hitung panjang rentang tanggal

    return Column(
      children: [
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () async {
            await showMonthPicker(
              context: context,
              locale: Locale("id", "ID"),
              initialDate: DateTime.now(),
              unselectedMonthTextColor: blackColor,
            ).then((date) {
              if (date != null) {
                setState(() {
                  controller.selectedDate = date;
                });
              }
            });
          },
          child: Container(
            width: Get.width,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: darkGreyColor,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.date_range_outlined),
                const SizedBox(width: 10),
                Text(
                  "${DateFormat("MMM yyyy", "id_ID").format(
                    DateTime(controller.startDate.year,
                        controller.startDate.month + 1),
                  )}",
                  style: blackTextStyle,
                ),
                new Spacer(),
                Icon(
                  Icons.arrow_drop_down_sharp,
                  color: darkGreyColor,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await controller.refreshInformation();
            },
            child: FutureBuilder(
              future: controller.authC.fetchDetailAbsensi(),
              builder: (context, snapshot) {
                if (snapshot.hasData ||
                    snapshot.connectionState == ConnectionState.done) {
                  return ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(10),
                        height: 150,
                        decoration: BoxDecoration(
                          color: blueColor.withAlpha(40),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() => ListTileInfo(
                                      title: "Absen",
                                      value: controller.absent.value,
                                    )),
                                ListTileInfo(
                                  title: "No clock in",
                                  value: 0,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTileInfo(
                                  title: "Late clock in",
                                  value: 0,
                                ),
                                Obx(
                                  () => ListTileInfo(
                                    title: "No clock out",
                                    value: controller.noClockOut.value,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTileInfo(
                                  title: "Early clock out",
                                  value: 0,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      ...List.generate(
                        controller.dateOfMonthLength(),
                        (index) => TileInfoTime(index, context),
                      ),
                    ],
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ],
    );
  }

  _reformatDate(DateTime paramDate) {
    return "${paramDate.year}-${paramDate.month.toString().padLeft(2, '0')}-${paramDate.day.toString().padLeft(2, '0')}";
  }

  // Fungsi untuk memformat waktu ke string "HH:MM:SS"
  String _formatTime(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  Container TileInfoTime(int index, BuildContext context) {
    String clockin = '';
    String clockout = '';
    List<DateTime?> detailDate = controller.authC.listUserAbsensi
        .map((element) => element.createdAt)
        .toList();

// Mendapatkan tanggal saat ini dalam format yang sesuai
    String curDate =
        _reformatDate(controller.startDate.add(Duration(days: index)));

// Mengambil tanggal yang cocok dengan tanggal saat ini
    List<DateTime?> filteredDates = detailDate
        .where((element) => _reformatDate(element!) == curDate)
        .toList();

// Jika ada tanggal yang sesuai
    if (filteredDates.isNotEmpty) {
      // Mengurutkan tanggal dari yang tercepat ke yang terakhir
      filteredDates.sort();

      // Mengatur clockin menjadi waktu pertama
      clockin = _formatTime(filteredDates.first!);

      // Jika ada lebih dari satu tanggal, mengatur clockout menjadi waktu terakhir
      if (filteredDates.length > 1) {
        controller.absent.value -= 1;
        clockout = _formatTime(filteredDates.last!);
      }

      if (clockin.isNotEmpty && clockout.isEmpty) {
        controller.absent.value -= 1;
        controller.noClockOut += 1;
      }
    }
// == END LOGIC ==

    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat("dd MMM", "id_ID").format(
                      controller.startDate.add(
                        Duration(days: index),
                      ),
                    ),
                    style: (controller.checkIsHoliday(
                            controller.startDate.add(Duration(days: index))))
                        ? GoogleFonts.outfit(
                            color: Colors.red,
                            fontSize: 16,
                          )
                        : blackTextStyle.copyWith(
                            fontSize: 16,
                          ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    (controller.checkIsHoliday(
                            controller.startDate.add(Duration(days: index))))
                        ? "Hari libur"
                        : 'Jam kerja',
                    style: (controller.checkIsHoliday(
                            controller.startDate.add(Duration(days: index))))
                        ? redTextStyle
                        : blackTextStyle,
                  ),
                ],
              ),
              Text(
                (clockin.isEmpty) ? "-" : clockin,
                style: GoogleFonts.lexend(
                  fontWeight: regular,
                  fontSize: 15,
                ),
              ),
              Text(
                (clockout.isEmpty) ? "-" : clockout,
                style: GoogleFonts.lexend(
                  fontWeight: regular,
                  fontSize: 15,
                ),
              ),
              IconButton(
                onPressed: () {
                  ShowDetailAbsensi(context, index, clockin, clockout);
                },
                icon: Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: darkGreyColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Divider(
            thickness: 1,
            color: darkGreyColor,
          ),
        ],
      ),
    );
  }

  Future<dynamic> ShowDetailAbsensi(
      BuildContext context, int index, String clockin, String clockout) {
    return showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Container(
          width: Get.width,
          height: 250,
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${DateFormat("EEE, dd MMM yyyy", "id_ID").format(controller.startDate.add(Duration(days: index)))}",
                style: blackTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 16,
                ),
              ),
              const Gap(20),
              Text(
                "Office (08:00-16:45)",
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                width: Get.width,
                child: Divider(
                  thickness: 1,
                  color: darkGreyColor,
                ),
              ),
              Expanded(
                child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: blueColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: (controller.startDate
                                  .add(Duration(days: index))
                                  .weekday ==
                              DateTime.saturday ||
                          controller.startDate
                                  .add(Duration(days: index))
                                  .weekday ==
                              DateTime.sunday)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Detail log Anda akan muncul jika Anda telah melakukan clock in/out.",
                              textAlign: TextAlign.center,
                              style: blackTextStyle.copyWith(
                                fontWeight: regular,
                                fontSize: 14,
                              ),
                            )
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Text(
                            //   "Anda tidak ada shift di tanggal ini",
                            //   textAlign: TextAlign.center,
                            //   style: blackTextStyle.copyWith(
                            //     fontWeight: regular,
                            //     fontSize: 14,
                            //   ),
                            // )
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      (clockin.isEmpty)
                                          ? "Belum Clock-In"
                                          : clockin,
                                      style: blackTextStyle.copyWith(
                                        fontWeight: semiBold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    new Spacer(),
                                    Text(
                                      "Status Pengajuan",
                                      style: blackTextStyle.copyWith(
                                        fontWeight: medium,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Gap(10),
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      (clockout.isEmpty)
                                          ? "Belum Clock-Out"
                                          : clockout,
                                      style: blackTextStyle.copyWith(
                                        fontWeight: semiBold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    new Spacer(),
                                    Text(
                                      "Status Pengajuan",
                                      style: blackTextStyle.copyWith(
                                        fontWeight: medium,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ListTileInfo extends StatelessWidget {
  const ListTileInfo({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: blackTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
        Text(
          value.toString(),
          style: blueTextStyle.copyWith(fontWeight: bold),
        ),
      ],
    );
  }
}
