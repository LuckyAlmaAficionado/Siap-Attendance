import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:talenta_app/app/routes/app_pages.dart';
import 'package:talenta_app/app/shared/utils.dart';

class DetailAbsenView extends StatelessWidget {
  DetailAbsenView({super.key, required this.status});

  final bool status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: Image.asset((status)
                    ? "assets/icons/ic_success.png"
                    : "assets/icons/ic_failed.png"),
              ),
              const Gap(10),
              Text(
                (status) ? "Absensi Berhasil" : "Absensi Gagap",
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  color: (status) ? Colors.green : Colors.red,
                  fontSize: 20,
                ),
              ),
              const Gap(10),
              Text(
                DateFormat("HH:mm", "id_ID").format(DateTime.now()),
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.bold,
                  color: (status) ? Colors.green : Colors.red,
                  fontSize: 30,
                ),
              ),
              Gap(Get.height * 0.35),
              CustomButton(
                title: 'Kembali',
                onTap: () => Get.offAllNamed(Routes.DASHBOARD_PAGE),
              )
            ],
          ),
        ),
      ),
    );
  }
}
