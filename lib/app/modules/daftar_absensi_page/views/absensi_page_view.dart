import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import 'package:talenta_app/app/modules/daftar_absensi_page/controllers/daftar_absensi_page_controller.dart';
import 'package:talenta_app/app/modules/daftar_absensi_page/views/pengajuan_absensi_view.dart';
import 'package:talenta_app/app/modules/persetujuan_page/views/status_persetujuan_view.dart';
import 'package:talenta_app/app/shared/button/button_1.dart';

import '../../../shared/textfield/textfield_1.dart';
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
  TextEditingController calendarC = TextEditingController();

  @override
  void initState() {
    super.initState();
    calendarC.text = DateFormat("MMMM yyyy", "id_ID").format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                new Row(
                  children: [
                    new Flexible(
                      child: new TextField1(
                        readOnly: true,
                        suffixIcon: HeroIcon(HeroIcons.chevronDown, size: 15),
                        preffixIcon: HeroIcon(HeroIcons.calendarDays),
                        controller: calendarC,
                        onTap: () {
                          showMonthPicker(
                            context: context,
                            locale: Locale("id", "ID"),
                            initialDate: DateTime.now(),
                            unselectedMonthTextColor: Colors.black,
                          ).then((date) {
                            if (date != null) {
                              setState(() {
                                calendarC.text =
                                    DateFormat("MMMM yyyy", "id_ID")
                                        .format(date);
                              });
                            }
                          });
                        },
                      ),
                    ),
                    const Gap(10),
                    InkWell(
                      onTap: () {
                        Get.bottomSheet(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              height: 300,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Gap(10),
                                  Text(
                                    'Filter',
                                    textAlign: TextAlign.center,
                                    style: normalTextStyle.copyWith(
                                      fontWeight: semiBold,
                                      fontSize: 16,
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
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(11.5),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.3),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: HeroIcon(HeroIcons.adjustmentsVertical),
                      ),
                    ),
                  ],
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
                                            "${DateFormat("dd MMMM yyyy", "id_ID").format(DateTime.now())}",
                                            style: normalTextStyle.copyWith(
                                              fontWeight: regular,
                                              fontSize: 14,
                                            )),
                                        const Gap(5),
                                        Text(
                                          "Clock In pada ${DateFormat("dd MMM yyyy, HH:MM").format(DateTime.now())}",
                                          style: normalTextStyle.copyWith(
                                            color: darkGreyColor,
                                            fontSize: 12,
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
