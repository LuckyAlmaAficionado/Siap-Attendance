import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:talenta_app/app/shared/theme.dart';

import '../controllers/detail_pengumuman_controller.dart';

class DetailPengumumanView extends GetView<DetailPengumumanController> {
  const DetailPengumumanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const Gap(10),
              Text(
                "Crimirlaizing Palestine Solidarity Activism",
                style: normalTextStyle.copyWith(
                  fontSize: 25,
                  fontWeight: extraBold,
                ),
              ),
              const Gap(10),
              Text(
                "${DateFormat("dd MMM yyyy").format(DateTime.now())}",
                style: normalTextStyle.copyWith(
                  fontSize: 12,
                  color: darkGreyColor,
                ),
              ),
              const Gap(10),
              Row(
                children: [
                  CircleAvatar(),
                  const Gap(10),
                  Text(
                    "Scott Jhonson",
                    style: normalTextStyle.copyWith(
                      fontWeight: bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const Gap(30),
              Text(
                'Isi dari pengumuman contoh\n\nMohon perhatian !\n\nYuk cek absensimu di TALENTA\n\nMasuk ke menu daftar absensi (Lihat gambar)\n\nuntuk karyawan yang memiliki absen lembur, silahkan cek juga.\n\nJika terdapat data yang tidak sesuai dapat langsung WA ke nomor personalia.',
                style: normalTextStyle.copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
