import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:talenta_app/app/modules/akun_services/info_saya/ajukan_perubahan_data_view.dart';

import '../../../../shared/theme.dart';

class InfoPayrollView extends GetView {
  const InfoPayrollView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Info Personal",
            style: appBarTextStyle.copyWith(fontWeight: extraBold),
          ),
          actions: [
            IconButton(
              onPressed: () => Get.to(AjukanPerubahanDataView(),
                  transition: Transition.cupertino),
              icon: Icon(Iconsax.edit),
            )
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
          ),
          children: [
            // InfoPersonalTile(
            //   title: "BPJS Ketenagakerjaan",
            //   subTitle: "-",
            // ),
            // InfoPersonalTile(
            //   title: "BPJS Kesehatan",
            //   subTitle: "-",
            // ),
            // InfoPersonalTile(
            //   title: "Nama Bank",
            //   subTitle: "Other",
            // ),
            // InfoPersonalTile(
            //   title: "No Rekening Bank",
            //   subTitle: "Other",
            // ),
            // InfoPersonalTile(
            //   title: "Nama Pemilik Rekening",
            //   subTitle: "-",
            // ),
            // InfoPersonalTile(
            //   title: "Status PTKP",
            //   subTitle: "TK/0",
            // ),
          ],
        ));
  }
}
