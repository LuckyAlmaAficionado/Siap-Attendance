import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../../../shared/theme.dart';

class DelegasiPageView extends StatefulWidget {
  const DelegasiPageView({super.key});

  @override
  State<DelegasiPageView> createState() => _DelegasiPageViewState();
}

enum Sorting { semuaStatus, menunggu, disetujui, tidakDisetujui, dibatalkan }

class _DelegasiPageViewState extends State<DelegasiPageView> {
  Sorting enumSorting = Sorting.semuaStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Semua Status",
                                  style: darkGreyTextStyle,
                                ),
                                Radio<Sorting>(
                                  value: Sorting.semuaStatus,
                                  groupValue: enumSorting,
                                  onChanged: (value) {
                                    enumSorting = value!;
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
                                  style: darkGreyTextStyle,
                                ),
                                Radio<Sorting>(
                                  value: Sorting.menunggu,
                                  groupValue: enumSorting,
                                  onChanged: (value) {
                                    enumSorting = value!;
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
                                  style: darkGreyTextStyle,
                                ),
                                Radio<Sorting>(
                                  value: Sorting.disetujui,
                                  groupValue: enumSorting,
                                  onChanged: (value) {
                                    enumSorting = value!;
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
                                  style: darkGreyTextStyle,
                                ),
                                Radio<Sorting>(
                                  value: Sorting.tidakDisetujui,
                                  groupValue: enumSorting,
                                  onChanged: (value) {
                                    enumSorting = value!;
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
                                  style: darkGreyTextStyle,
                                ),
                                Radio<Sorting>(
                                  value: Sorting.dibatalkan,
                                  groupValue: enumSorting,
                                  onChanged: (value) {
                                    enumSorting = value!;
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
          Expanded(
            child: (false)
                ? ListView()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.asset(
                          "assets/images/img_shift.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        'Belum ada pengajuan delegasi',
                        style: blackTextStyle.copyWith(
                          fontWeight: semiBold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "pengajuan delegasi Anda akan tampil di sini.",
                        style: darkGreyTextStyle.copyWith(
                          fontWeight: extraLight,
                          fontSize: 14,
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
