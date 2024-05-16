import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:talenta_app/app/controllers/model_controller.dart';
import 'package:talenta_app/app/models/users.dart';
import 'package:talenta_app/app/modules/akun_services/info_saya/ajukan_perubahan_data_view.dart';
import 'package:talenta_app/app/shared/theme.dart';

// ignore: must_be_immutable
class InfoPersonalPageView extends GetView {
  ModelUser m = Get.find<ModelController>().u.value.user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => Get.to(
                () => AjukanPerubahanDataView(),
                transition: Transition.cupertino,
              ),
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
            Text(
              'Info Personal',
              style:
                  blackTextStyle.copyWith(fontWeight: semiBold, fontSize: 20),
            ),
            const SizedBox(height: 20),
            InfoPersonalTile(
              title: "Nama Depan",
              subTitle: "${m.nama ?? ""}",
            ),
            InfoPersonalTile(
              title: "Email",
              subTitle: "${m.email ?? ""}",
            ),
            InfoPersonalTile(
              title: "Jenis Kelamin",
              subTitle: "${m.jenisKelamin ?? ""}",
            ),
            InfoPersonalTile(
              title: "Tempat Lahir",
              subTitle: "${m.tempatLahir ?? "-"}",
            ),
            InfoPersonalTile(
              title: "Tanggal Lahir",
              subTitle: "${m.tanggalLahir ?? "-"}",
            ),
            InfoPersonalTile(
              title: "Handphone",
              subTitle: "${m.telepon ?? "-"}",
            ),
            InfoPersonalTile(
              title: "Status Pernikahan",
              subTitle: "${m.statusPernikahan ?? "-"}",
            ),
            InfoPersonalTile(
              title: "Agama",
              subTitle: "${m.agama ?? "-"}",
            ),
            InfoPersonalTile(
              title: "Nomor ID",
              subTitle: "${m.id}",
            ),
            InfoPersonalTile(
              title: "Tipe ID",
              subTitle: "KTP",
            ),
            InfoPersonalTile(
              title: "Tipe ID",
              subTitle: "KTP",
            ),
            InfoPersonalTile(
              title: "Tanggal Kadarluasa",
              subTitle: "Permanen",
            ),
            InfoPersonalTile(
              title: "Alamat Sesuai Identitas",
              subTitle: "${m.alamat}",
            ),
            InfoPersonalTile(
              title: "Kode Pos",
              subTitle: "-",
            ),
            InfoPersonalTile(
              title: "Alamat Tempat Tinggal",
              subTitle: "${m.alamat}",
            ),
            InfoPersonalTile(
              title: "Golongan Darah",
              subTitle: "${m.golDarah}",
            ),
          ],
        ));
  }
}

class InfoPersonalTile extends StatelessWidget {
  const InfoPersonalTile({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: normalTextStyle.copyWith(color: darkGreyColor)),
        const SizedBox(height: 5),
        Text(subTitle, style: normalTextStyle.copyWith(fontSize: 16)),
        Divider(thickness: 1, color: darkGreyColor),
      ],
    );
  }
}
