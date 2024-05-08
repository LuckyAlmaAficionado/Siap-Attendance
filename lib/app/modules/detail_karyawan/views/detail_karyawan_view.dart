import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../shared/theme.dart';
import '../controllers/detail_karyawan_controller.dart';

class DetailKaryawanView extends GetView<DetailKaryawanController> {
  const DetailKaryawanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(180),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(radius: 35),
              const Gap(10),
              Text(
                "${controller.karyawan.name}",
                style: whiteTextStyle.copyWith(
                  fontWeight: extraBold,
                  fontSize: 20,
                ),
              ),
              const Gap(5),
              Text(
                "${controller.karyawan.jabatan}",
                style: whiteTextStyle.copyWith(
                  fontWeight: regular,
                  fontSize: 12,
                ),
              ),
              const Gap(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {},
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(Iconsax.call, color: blueColor),
                      ),
                    ),
                  ),
                  const Gap(20),
                  InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {},
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(Iconsax.message, color: blueColor),
                      ),
                    ),
                  )
                ],
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          _CustomInformations(
            title: "Cabang",
            subTitle: "${controller.karyawan.cabang}",
          ),
          _CustomInformations(
            title: "ID Karyawan",
            subTitle: "${controller.karyawan.id}",
          ),
          _CustomInformations(
            title: "Posisi pekerjaan",
            subTitle: "${controller.karyawan.posisiKaryawan}",
          ),
          _CustomInformations(
            title: "Nama Organisasi",
            subTitle: "${controller.karyawan.namaOrganisasi}",
          ),
        ],
      ),
    );
  }
}

class _CustomInformations extends StatelessWidget {
  const _CustomInformations({
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: darkGreyTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                width: Get.width * 0.55,
                child: Text(
                  subTitle,
                  textAlign: TextAlign.left,
                  style: blackTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(thickness: 1, color: darkGreyColor),
      ],
    );
  }
}
