import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:talenta_app/app/modules/settings/views/info_personal_view.dart';

import '../../../controllers/api_controller.dart';
import '../../../controllers/model_controller.dart';
import '../../../models/user_job.dart';
import '../../../shared/theme.dart';

class InfoPekerjaanView extends GetView {
  InfoPekerjaanView({Key? key}) : super(key: key);

  final a = Get.put(ApiController());
  final m = Get.find<ModelController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Info Perkerjaan',
          style: appBarTextStyle.copyWith(color: blackColor),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        titleSpacing: 0,
        iconTheme: IconThemeData(color: blackColor),
        actions: [
          IconButton(
            onPressed: () {},
            icon: HeroIcon(
              HeroIcons.pencilSquare,
              color: Colors.pink,
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: a.fetchUserJob(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            UserJobModel models = snapshot.data;

            return ListView(
              children: [
                const Gap(20),
                ListTileInfoPersonal(
                  title: "ID Karyawan",
                  subTitle: "${models.idKaryawan}",
                ),
                ListTileInfoPersonal(
                  title: "Barcode",
                  subTitle: "${models.idKaryawan}",
                ),
                ListTileInfoPersonal(
                  title: "Nama Perusahaan",
                  subTitle: "Andi Offset",
                ),
                ListTileInfoPersonal(
                  title: "Cabang",
                  subTitle: "${m.u.value!.cabang}",
                ),
                ListTileInfoPersonal(
                  title: "Nama Organisasi",
                  subTitle: "${m.u.value!.divisi!.split(" ").last}",
                ),
                ListTileInfoPersonal(
                  title: "Posisi Pekerjaan",
                  subTitle: "${m.u.value!.jabatan}",
                ),
                ListTileInfoPersonal(
                  title: "Level Pekerjaan",
                  subTitle: "${models.levelPekerjaanId["nama"]}",
                ),
                ListTileInfoPersonal(
                  title: "Status Pekerjaan",
                  subTitle: "${models.statusPekerjaan}",
                ),
                ListTileInfoPersonal(
                  title: "Tanggal Bergabung",
                  subTitle:
                      "${DateFormat("dd MMMM yyyy", "id_ID").format(models.tglBergabung!)}",
                ),
                ListTileInfoPersonal(
                  title: "Masa Berakhir Kontrak",
                  subTitle:
                      "${DateFormat("dd MMMM yyyy", "id_ID").format(models.tglBerakhir!)}",
                ),
                ListTileInfoPersonal(
                  title: "Masa Kerja",
                  subTitle:
                      "${calculateWorkDuration(models.tglBergabung!, DateTime.now().add(Duration(days: 1)))}",
                ),
              ],
            );
          }

          return Center(
            child: Text(
              "Error 404",
              style: normalTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
          );
        },
      ),
    );
  }

  String calculateWorkDuration(DateTime startDate, DateTime endDate) {
    String result = "";

    int years = endDate.year - startDate.year;
    int months = endDate.month - startDate.month;
    int days = endDate.day - startDate.day;

    if (days < 0) {
      final previousMonth = DateTime(endDate.year, endDate.month, 0);
      days += previousMonth.day;
      months--;
    }

    if (months < 0) {
      months += 12;
      years--;
    }

    result = '$years year $months month $days day';

    return result;
  }
}
