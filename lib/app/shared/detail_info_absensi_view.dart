import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:talenta_app/app/routes/app_pages.dart';
import 'package:talenta_app/app/shared/theme.dart';
import 'package:talenta_app/app/shared/utils.dart';

class DetailInfoAbsensiView extends StatefulWidget {
  const DetailInfoAbsensiView({super.key});

  @override
  State<DetailInfoAbsensiView> createState() => _DetailInfoAbsensiViewState();
}

class _DetailInfoAbsensiViewState extends State<DetailInfoAbsensiView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Get.offAllNamed(Routes.DASHBOARD_PAGE);
                  },
                  icon: Icon(Icons.close),
                ),
              ),
              const Gap(40),
              Icon(
                Icons.check_circle_outlined,
                color: greenColor,
                size: 100,
              ),
              const Gap(10),
              Text(
                "Jam keluar berhasil",
                style: blackTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 30,
                ),
              ),
              const Gap(25),
              Text(
                "Jadwal: ${DateFormat("dd MMMM yyyy").format(DateTime.now())}",
                style: darkGreyTextStyle.copyWith(
                  fontWeight: extraLight,
                ),
              ),
              Text(
                "Office2",
                style: darkGreyTextStyle.copyWith(
                  fontWeight: semiBold,
                ),
              ),
              Text(
                "08:00 - 16:45",
                style: darkGreyTextStyle.copyWith(
                  fontWeight: semiBold,
                ),
              ),
              const Gap(30),
              Text(
                "${DateFormat("hh:mm").format(DateTime.now())}",
                style: blackTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 30,
                ),
              ),
              const Gap(50),
              Text("Deteksi wajah: berhasil"),
              new Spacer(),
              CustomButton(
                title: "Kembali ke beranda",
                onTap: () => Get.toNamed(Routes.DASHBOARD_PAGE),
              ),
              TextButton(
                onPressed: () => Get.offAllNamed(Routes.DAFTAR_ABSENSI_PAGE),
                child: Text("Lihat daftar absensi"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
