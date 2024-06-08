import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';

import 'package:talenta_app/app/controllers/api_controller.dart';
import 'package:talenta_app/app/controllers/model_controller.dart';
import 'package:talenta_app/app/shared/theme.dart';

class InfoPersonalView extends GetView {
  InfoPersonalView({Key? key}) : super(key: key);

  final a = Get.put(ApiController());
  final m = Get.find<ModelController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Info Personal',
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
            // UserJobModel models = snapshot.data;

            return ListView(
              children: [
                const Gap(20),
                ListTileInfoPersonal(
                  title: "Nama Depan",
                  subTitle: "${m.u.value!.nama}",
                ),
                ListTileInfoPersonal(
                  title: "Nama Belakang",
                  subTitle: "${m.u.value!.nama!.split(" ").last}",
                ),
                ListTileInfoPersonal(
                  title: "Email",
                  subTitle: "${m.u.value!.email}",
                ),
                ListTileInfoPersonal(
                  title: "Jenis Kelamin",
                  subTitle: "${m.u.value!.jenisKelamin}",
                ),
                ListTileInfoPersonal(
                  title: "Tempat Lahir",
                  subTitle: "${m.u.value!.tempatLahir}",
                ),
                ListTileInfoPersonal(
                  title: "Tanggal Lahir",
                  subTitle: "${m.u.value!.tanggalLahir}",
                ),
                ListTileInfoPersonal(
                  title: "Handphone",
                  subTitle: "${m.u.value!.telepon}",
                ),
                ListTileInfoPersonal(
                  title: "Telepon",
                  subTitle: "${m.u.value!.telepon}",
                ),
                ListTileInfoPersonal(
                  title: "Status Pernikahan",
                  subTitle: "${m.u.value!.statusPernikahan}",
                ),
                ListTileInfoPersonal(
                  title: "Agama",
                  subTitle: "${m.u.value!.agama}",
                ),
                ListTileInfoPersonal(
                  title: "Alamat Sesuai Identitas",
                  subTitle: "${m.u.value!.alamat}",
                ),
                ListTileInfoPersonal(
                  title: "Alamat Sesuai Tanggal",
                  subTitle: "${m.u.value!.alamat}",
                ),
                ListTileInfoPersonal(
                  title: "Golongan Darah",
                  subTitle: "${m.u.value!.golDarah}",
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
}

class ListTileInfoPersonal extends StatelessWidget {
  const ListTileInfoPersonal({
    super.key,
    this.title,
    this.subTitle,
  });

  final title;
  final subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: normalTextStyle.copyWith(
              color: Colors.grey.shade700,
            ),
          ),
          const Gap(5),
          Text(
            subTitle != "null" ? subTitle : "-",
            style: normalTextStyle.copyWith(
              fontWeight: regular,
              fontSize: 14,
            ),
          ),
          Divider(
            thickness: 0.5,
            color: darkGreyColor,
          ),
        ],
      ),
    );
  }
}
