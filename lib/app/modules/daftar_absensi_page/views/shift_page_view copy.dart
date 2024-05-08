import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:talenta_app/app/modules/daftar_absensi_page/controllers/daftar_absensi_page_controller.dart';

import '../../../shared/theme.dart';

class ShiftPageView extends StatefulWidget {
  const ShiftPageView({super.key});

  @override
  State<ShiftPageView> createState() => _AbsensiPageViewState();
}

enum Sorting { semuaStatus, menunggu, disetujui, tidakDisetujui, dibatalkan }

class _AbsensiPageViewState extends State<ShiftPageView> {
  final daftarC = Get.put(DaftarAbsensiPageController());
  Sorting enumSorting = Sorting.semuaStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    await showMonthYearPicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(3000),
                    );
                  },
                  child: Container(
                    width: (Get.width * 0.82) - 10,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: darkGreyColor),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: darkGreyColor,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "${DateFormat("MMM yyyy").format(DateTime.now())} - ${DateFormat("MMM yyyy").format(DateTime.now())}",
                          style: blackTextStyle.copyWith(fontWeight: regular),
                        ),
                        new Spacer(),
                        Icon(
                          Icons.arrow_drop_down_outlined,
                          color: darkGreyColor,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // FILTER
                GestureDetector(
                  onTap: () async {
                    await showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Filter',
                                      textAlign: TextAlign.center,
                                      style: blackTextStyle.copyWith(
                                          fontWeight: semiBold, fontSize: 16),
                                    ),
                                  ),
                                  Icon(
                                    Icons.close,
                                    color: darkGreyColor,
                                  ),
                                ],
                              ),
                              Text(
                                'Status',
                                style: blackTextStyle.copyWith(
                                  fontWeight: semiBold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Semua Status",
                                    style: darkGreyTextStyle,
                                  ),
                                  Radio<Sorting>(
                                    value: Sorting.semuaStatus,
                                    groupValue: enumSorting,
                                    onChanged: (value) {
                                      setState(() {
                                        enumSorting = value!;
                                      });
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Menunggu",
                                    style: darkGreyTextStyle,
                                  ),
                                  Radio<Sorting>(
                                    value: Sorting.menunggu,
                                    groupValue: enumSorting,
                                    onChanged: (value) {
                                      setState(() {
                                        enumSorting = value!;
                                      });
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Disetujui",
                                    style: darkGreyTextStyle,
                                  ),
                                  Radio<Sorting>(
                                    value: Sorting.disetujui,
                                    groupValue: enumSorting,
                                    onChanged: (value) {
                                      setState(() {
                                        enumSorting = value!;
                                      });
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Tidak disetujui",
                                    style: darkGreyTextStyle,
                                  ),
                                  Radio<Sorting>(
                                    value: Sorting.tidakDisetujui,
                                    groupValue: enumSorting,
                                    onChanged: (value) {
                                      setState(() {
                                        enumSorting = value!;
                                      });
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Dibatalkan",
                                    style: darkGreyTextStyle,
                                  ),
                                  Radio<Sorting>(
                                    value: Sorting.dibatalkan,
                                    groupValue: enumSorting,
                                    onChanged: (value) {
                                      setState(() {
                                        enumSorting = value!;
                                      });
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: Get.width * 0.15 - 10,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: darkGreyColor),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.filter_alt_outlined,
                        color: darkGreyColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: (true)
                ? Column(
                    children: [
                      Container(
                        width: 300,
                        height: 230,
                        child: Image.asset(
                          "assets/images/img_shift.png",
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        "Belum ada pengajuan",
                        style: blackTextStyle.copyWith(
                          fontWeight: semiBold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "pengajuan penggantian shif Anda akan\ntampil di sini",
                        textAlign: TextAlign.center,
                        style: darkGreyTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                : ListView(
                    physics: BouncingScrollPhysics(),
                    children: List.generate(
                      3,
                      (index) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${DateFormat("dd MMM yyyy").format(DateTime.now())}",
                                      style: blackTextStyle.copyWith(
                                        fontWeight: regular,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      "Clock In pada ${DateFormat("dd MMM yyyy, HH:MM").format(DateTime.now())}",
                                      style: darkGreyTextStyle.copyWith(
                                        fontWeight: regular,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Disetujui",
                                      style: greenTextStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: extraLight,
                                      ),
                                    ),
                                  ],
                                ),
                                new Spacer(),
                                Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  color: darkGreyColor,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            new Divider(
                              thickness: 1,
                              color: darkGreyColor.withAlpha(100),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
