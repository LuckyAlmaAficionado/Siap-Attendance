import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:talenta_app/app/controllers/authentication_controller.dart';
import 'package:talenta_app/app/models/users.dart';
import 'package:talenta_app/app/modules/akun_services/info_saya/ajukan_perubahan_data_view.dart';
import 'package:talenta_app/app/shared/theme.dart';

// ignore: must_be_immutable
class InfoPersonalPageView extends GetView {
  AuthenticationController authC = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    User user = authC.data.value!;

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => Get.to((AjukanPerubahanDataView()),
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
            Text(
              'Info Personal',
              style:
                  blackTextStyle.copyWith(fontWeight: semiBold, fontSize: 20),
            ),
            const SizedBox(height: 20),
            InfoPersonalTile(
              title: "Nama Depan",
              subTitle: "${user.data.user.nama}",
            ),
            // InfoPersonalTile(
            //   title: "Nama Belakang",
            //   subTitle: "Rigel",
            // ),
            InfoPersonalTile(
              title: "Email",
              subTitle: "${user.data.user.email}",
            ),
            InfoPersonalTile(
              title: "Jenis Kelamin",
              subTitle: "${user.data.user.jenisKelamin ?? "-"}",
            ),
            InfoPersonalTile(
              title: "Tempat Lahir",
              subTitle: "${user.data.user.tempatLahir ?? "-"}",
            ),
            InfoPersonalTile(
              title: "Tanggal Lahir",
              subTitle: "${user.data.user.tanggalLahir ?? "-"}",
            ),
            InfoPersonalTile(
              title: "Handphone",
              subTitle: "${user.data.user.telepon ?? "-"}",
            ),
            InfoPersonalTile(
              title: "Status Pernikahan",
              subTitle: "${user.data.user.statusPernikahan ?? "-"}",
            ),
            InfoPersonalTile(
              title: "Agama",
              subTitle: "${user.data.user.agama ?? "-"}",
            ),
            InfoPersonalTile(
              title: "Nomor ID",
              subTitle: "${user.data.user.id}",
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
              subTitle: "${user.data.user.alamat}",
            ),
            InfoPersonalTile(
              title: "Kode Pos",
              subTitle: "-",
            ),
            InfoPersonalTile(
              title: "Alamat Tempat Tinggal",
              subTitle: "${user.data.user.alamat}",
            ),
            InfoPersonalTile(
              title: "Golongan Darah",
              subTitle: "${user.data.user.golDarah}",
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
        Text(
          title,
          style: darkGreyTextStyle.copyWith(fontSize: 14),
        ),
        const SizedBox(height: 5),
        Text(
          subTitle,
          style: blackTextStyle.copyWith(fontSize: 16),
        ),
        Divider(
          thickness: 1,
          color: darkGreyColor,
        ),
      ],
    );
  }
}
