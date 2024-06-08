import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:talenta_app/app/modules/cuti_page/views/pengajuan_cuti_view.dart';
import 'package:talenta_app/app/shared/button/button_1.dart';
import 'package:talenta_app/app/shared/textfield/textfield_1.dart';

import '../../../shared/theme.dart';

class PengajuanStatusPageView extends StatefulWidget {
  const PengajuanStatusPageView({super.key});

  @override
  State<PengajuanStatusPageView> createState() =>
      _PengajuanStatusPageViewState();
}

enum Sorting { semuaStatus, menunggu, disetujui, tidakDisetujui, dibatalkan }

class _PengajuanStatusPageViewState extends State<PengajuanStatusPageView> {
  Sorting enumSorting = Sorting.semuaStatus;
  TextEditingController calendarC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: new Row(
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
                              DateFormat("MMMM yyyy", "id_ID").format(date);
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        ),
        Expanded(
          child: (false)
              ? ListView()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SizedBox(
                    //   width: Get.width * 0.4,
                    //   height: Get.height * 0.2,
                    //   child: Image.asset(
                    //     "assets/images/img_shift.png",
                    //     fit: BoxFit.contain,
                    //   ),
                    // ),
                    HeroIcon(
                      HeroIcons.folderOpen,
                      size: 80,
                    ),
                    Text(
                      'Belum ada pengajuan',
                      style: normalTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "pengajuan cuti Anda akan tampil di sini.",
                      style: normalTextStyle.copyWith(
                        fontWeight: regular,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Button1(
            title: "Ajukan Cuti",
            onTap: () => Get.to(
              PengajuanCutiView(),
            ),
          ),
        ),
      ],
    );
  }
}
