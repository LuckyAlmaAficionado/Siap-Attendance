import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:talenta_app/app/controllers/model_controller.dart';
import 'package:talenta_app/app/modules/home/views/menu_view.dart';

import 'package:talenta_app/app/shared/utils.dart';

class DetailAbsenView extends StatelessWidget {
  DetailAbsenView({super.key, required this.status, required this.stat});

  final bool status;
  final String stat;
  final m = Get.put(ModelController());

  DateTime formatTime(String time) {
    DateTime dateTime = DateFormat('HH:mm:ss').parse(time);
    return dateTime;
  }

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
                (status) ? "Absensi Berhasil" : "Absensi Gagal",
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
                  color: checkColors(stat),
                  fontSize: 30,
                ),
              ),
              Gap(Get.height * 0.35),
              CustomButton(
                title: 'Kembali',
                onTap: () => Get.offAll(() => MenuView()),
              )
            ],
          ),
        ),
      ),
    );
  }

  checkColors(String stat) {
    if (stat == "clockout") {
      // jika jam sekarang itu setelah jam
      if (DateTime.now().isAfter(formatTime(m.shiftC.value.scheduleOut!))) {
        return Colors.green;
      }
      return Colors.red;
    } else if (stat == "clockin") {
      if (DateTime.now().isAfter(formatTime(m.shiftC.value.scheduleIn!))) {
        return Colors.red;
      }
      return Colors.green;
    }
  }
}
