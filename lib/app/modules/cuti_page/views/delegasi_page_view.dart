import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../../../shared/textfield/textfield_1.dart';
import '../../../shared/theme.dart';

class DelegasiPageView extends StatefulWidget {
  const DelegasiPageView({super.key});

  @override
  State<DelegasiPageView> createState() => _DelegasiPageViewState();
}

enum Sorting { semuaStatus, menunggu, disetujui, tidakDisetujui, dibatalkan }

class _DelegasiPageViewState extends State<DelegasiPageView> {
  Sorting enumSorting = Sorting.semuaStatus;
  TextEditingController calendarC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          ),
          Expanded(
            child: (false)
                ? ListView()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      HeroIcon(
                        HeroIcons.folderOpen,
                        size: 100,
                      ),
                      Text(
                        'Belum ada pengajuan delegasi',
                        style: normalTextStyle.copyWith(
                          fontWeight: semiBold,
                          fontSize: 16,
                        ),
                      ),
                      const Gap(5),
                      Text(
                        "pengajuan delegasi Anda akan tampil di sini.",
                        style: normalTextStyle.copyWith(
                          fontWeight: regular,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
