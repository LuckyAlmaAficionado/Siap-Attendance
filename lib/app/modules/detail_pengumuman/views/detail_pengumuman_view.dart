import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:talenta_app/app/shared/theme.dart';

import '../controllers/detail_pengumuman_controller.dart';

class DetailPengumumanView extends GetView<DetailPengumumanController> {
  const DetailPengumumanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pengumuman', style: appBarTextStyle),
        centerTitle: true,
        iconTheme: IconThemeData(color: whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text(
              'Nama pemosting',
              style: blackTextStyle.copyWith(
                fontWeight: semiBold,
              ),
            ),
            Text(
              'Diposting pada ${DateFormat("dd MMM yyyy").format(DateTime.now())}',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
            ),
            const Gap(20),
            Text(
              "Title Pengumuman",
              style: blackTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 20,
              ),
            ),
            const Gap(30),
            Text(
              'Isi dari pengumuman contoh\n\nMohon perhatian !\n\nYuk cek absensimu di TALENTA\n\nMasuk ke menu daftar absensi (Lihat gambar)\n\nuntuk karyawan yang memiliki absen lembur, silahkan cek juga.\n\nJika terdapat data yang tidak sesuai dapat langsung WA ke nomor personalia.',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
            ),
            const Gap(30),
            (false) ? Image.asset("name") : SizedBox(),
          ],
        ),
      ),
    );
  }
}
