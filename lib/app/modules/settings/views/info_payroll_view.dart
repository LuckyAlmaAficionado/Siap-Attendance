import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:talenta_app/app/modules/settings/views/info_personal_view.dart';
import 'package:talenta_app/app/shared/theme.dart';

class InfoPayrollView extends GetView {
  const InfoPayrollView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Info Paryroll',
            style: appBarTextStyle.copyWith(
              color: blackColor,
            ),
          ),
          titleSpacing: 0,
          backgroundColor: whiteColor,
          centerTitle: false,
          iconTheme: IconThemeData(color: Colors.black),
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
        body: ListView(
          children: [
            const Gap(20),
            ListTileInfoPersonal(
              title: "BPJS Ketenagakerjaan",
              subTitle: "-",
            ),
            ListTileInfoPersonal(
              title: "BPJS Kesehatan",
              subTitle: "-",
            ),
            ListTileInfoPersonal(
              title: "NPWP 15 digit (lama)",
              subTitle: "-",
            ),
            ListTileInfoPersonal(
              title: "NPWP 15 digit (baru)",
              subTitle: "-",
            ),
            ListTileInfoPersonal(
              title: "Nama Bank",
              subTitle: "-",
            ),
            ListTileInfoPersonal(
              title: "No Rekening Bank",
              subTitle: "-",
            ),
            ListTileInfoPersonal(
              title: "Nama Pemilik Rekening",
              subTitle: "-",
            ),
            ListTileInfoPersonal(
              title: "Status PTKP",
              subTitle: "-",
            ),
          ],
        ));
  }
}
