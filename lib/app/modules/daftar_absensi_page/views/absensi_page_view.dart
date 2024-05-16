import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:talenta_app/app/modules/daftar_absensi_page/controllers/daftar_absensi_page_controller.dart';
import 'package:talenta_app/app/modules/daftar_absensi_page/views/pengajuan_absensi_view.dart';
import 'package:talenta_app/app/modules/persetujuan_page/views/status_persetujuan_view.dart';
import 'package:talenta_app/app/shared/button/button_1.dart';
import 'package:talenta_app/app/shared/utils.dart';

import '../../../shared/theme.dart';

class AbsensiPageView extends StatefulWidget {
  const AbsensiPageView({super.key});

  @override
  State<AbsensiPageView> createState() => _AbsensiPageViewState();
}

enum Sorting { semuaStatus, menunggu, disetujui, tidakDisetujui, dibatalkan }

class _AbsensiPageViewState extends State<AbsensiPageView> {
  final daftarC = Get.put(DaftarAbsensiPageController());
  Sorting enumSorting = Sorting.semuaStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: Stack(
        children: [
          Column(
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
                              style: normalTextStyle.copyWith(
                                fontWeight: regular,
                                fontSize: 14,
                              ),
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
                                          style: normalTextStyle.copyWith(
                                              fontWeight: semiBold,
                                              fontSize: 16),
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
                                    style: normalTextStyle.copyWith(
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
                                        style: normalTextStyle.copyWith(
                                            color: darkGreyColor, fontSize: 14),
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
                                        style: normalTextStyle.copyWith(
                                            color: darkGreyColor, fontSize: 14),
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
                                        style: normalTextStyle.copyWith(
                                            color: darkGreyColor, fontSize: 14),
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
                                        style: normalTextStyle.copyWith(
                                            color: darkGreyColor, fontSize: 14),
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
                                        style: normalTextStyle.copyWith(
                                            color: darkGreyColor, fontSize: 14),
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
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    ...List.generate(
                      3,
                      (index) => GestureDetector(
                        onTap: () => Get.to(
                          StatusPersetujuanView(),
                          transition: Transition.cupertino,
                        ),
                        child: Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${DateFormat("dd MMM yyyy").format(DateTime.now())}",
                                        style: normalTextStyle.copyWith(
                                          fontWeight: regular,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const Gap(5),
                                      Text(
                                        "Clock In pada ${DateFormat("dd MMM yyyy, HH:MM").format(DateTime.now())}",
                                        style: normalTextStyle
                                            .copyWith(
                                              color: darkGreyColor,
                                              fontSize: 14,
                                            )
                                            .copyWith(
                                              fontWeight: regular,
                                              fontSize: 14,
                                            ),
                                      ),
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
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            left: 10,
            right: 10,
            bottom: 10,
            child: Button1(
              title: "Kirim Pengajuan",
              onTap: () => Get.to(
                () => PengajuanAbsensiView(),
                transition: Transition.cupertino,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
