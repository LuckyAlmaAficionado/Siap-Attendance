import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:talenta_app/app/modules/akun_services/info_saya/views/tambah_kontak_darurat_view_view.dart';
import 'package:talenta_app/app/shared/theme.dart';

class InfoKontakDaruratView extends GetView {
  const InfoKontakDaruratView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          actions: [
            TextButton(
              onPressed: () => Get.to(
                TambahKontakDaruratViewView(),
                transition: Transition.cupertino,
              ),
              child: Text(
                "Tambah",
                style: whiteTextStyle,
              ),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              "Info kontak darurat",
              style: blackTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 20,
              ),
            ),
            Column(
              children: [
                const Gap(20),
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Image.asset(
                    'assets/images/img_shift.png',
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  "Tidak ada info kontak darurat",
                  style: blackTextStyle.copyWith(
                    fontSize: 22,
                    fontWeight: semiBold,
                  ),
                ),
                const Gap(10),
                Text(
                  "Info kontak darurat akan muncul disini",
                  style: darkGreyTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: regular,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
