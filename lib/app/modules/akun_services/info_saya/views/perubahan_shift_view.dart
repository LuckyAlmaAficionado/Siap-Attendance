import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:talenta_app/app/controllers/date_controller.dart';
import 'package:talenta_app/app/shared/theme.dart';
import 'package:talenta_app/app/shared/utils.dart';

// ignore: must_be_immutable
class PerubahanShiftView extends GetView {
  PerubahanShiftView({Key? key}) : super(key: key);

  TextEditingController pilihTanggalC = TextEditingController();
  TextEditingController pilihShiftC = TextEditingController();
  TextEditingController pilihShiftBaruC = TextEditingController();
  TextEditingController alasanC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Pegajuan shift',
            style: appBarTextStyle,
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                const Gap(20),
                ListTile(
                  onTap: () async {
                    DateTime time =
                        await Get.put(DateController()).pickerDateTime(context);

                    pilihTanggalC.text =
                        DateFormat("dd MMMM yyyy", "id_ID").format(time);
                  },
                  leading: Icon(Icons.date_range_outlined),
                  title: Text(
                    "Pilih tanggal",
                    style: darkGreyTextStyle.copyWith(
                      fontWeight: regular,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: TextField(
                    controller: pilihTanggalC,
                    style: blackTextStyle,
                    readOnly: true,
                  ),
                  trailing: Icon(Icons.keyboard_arrow_down_rounded),
                ),
                ListTile(
                  leading: Icon(Icons.access_time),
                  title: Text(
                    "Pilih shift",
                    style: darkGreyTextStyle.copyWith(
                      fontWeight: regular,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: TextField(
                    style: blackTextStyle,
                    controller: pilihShiftC,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.access_time),
                  title: Text(
                    "Pilih shift baru",
                    style: darkGreyTextStyle.copyWith(
                      fontWeight: regular,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: TextField(
                    controller: pilihShiftBaruC,
                    style: blackTextStyle,
                  ),
                  trailing: Icon(Icons.keyboard_arrow_down_rounded),
                ),
                ListTile(
                  leading: Icon(Icons.format_align_left),
                  title: Text(
                    "Alasan",
                    style: darkGreyTextStyle.copyWith(
                      fontWeight: regular,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: TextField(
                    controller: alasanC,
                    style: blackTextStyle,
                  ),
                )
              ],
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: CustomButton(
                title: "Kirim pengajuan",
                onTap: () {},
              ),
            ),
          ],
        ));
  }
}
