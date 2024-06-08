import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:talenta_app/app/shared/images/images.dart';

import '../../../shared/theme.dart';
import '../controllers/detail_karyawan_controller.dart';

class DetailKaryawanView extends GetView<DetailKaryawanController> {
  const DetailKaryawanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   elevation: 0.5,
      //   title: Text(
      //     "Detail Karyawan",
      //     style: appBarTextStyle.copyWith(
      //       color: Colors.black,
      //     ),
      //   ),
      //   backgroundColor: Colors.white,
      //   iconTheme: IconThemeData(color: Colors.black),
      //   titleSpacing: 0,
      //   centerTitle: false,
      // ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width: context.width,
              height: context.height * 0.23,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color: Colors.pink.shade400,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: context.height * 0.16,
            child: Column(
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ImageNetwork(url: "${controller.karyawan.avatar}"),
                ),
                const Gap(15),
                Text(
                  "${controller.karyawan.name}",
                  style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: semiBold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "${controller.karyawan.jabatan}",
                  style: normalTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: medium,
                    color: darkGreyColor,
                  ),
                ),
                const Gap(20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: [
                    TileInformations(value: "+6287719857757"),
                    TileInformations(value: "luckyrigel9802@gmail.com"),
                    TileInformations(value: "@_luckyalmaaficionado"),
                  ],
                ),
                const Gap(20),
                InformationDetails(
                  title: "Cabang",
                  subTilte: "CV Andi Offset Yogyakarta",
                ),
                const Gap(15),
                InformationDetails(
                  title: "ID Karyawan",
                  subTilte: "3030",
                ),
                const Gap(15),
                InformationDetails(
                  title: "Posisi Pekerjaan",
                  subTilte: "AGS",
                ),
                const Gap(15),
                InformationDetails(
                  title: "Cabang",
                  subTilte: "CV Andi Offset Makassar",
                ),
              ],
            ),
          ),
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.4),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: HeroIcon(
                          HeroIcons.chevronLeft,
                          color: whiteColor,
                          size: 20,
                        ),
                      ),
                    ),
                    Text(
                      "Profile Karyawan",
                      style: normalTextStyle.copyWith(
                        color: whiteColor,
                        fontWeight: semiBold,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: HeroIcon(
                        HeroIcons.chevronLeft,
                        color: Colors.transparent,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // body: Column(
      //   children: [
      //     Container(
      //       width: Get.width,
      //       color: lightGreyColor,
      //       padding: const EdgeInsets.symmetric(vertical: 20),
      //       child: Column(
      //         children: [
      //           SizedBox(
      //             width: 70,
      //             height: 70,
      //             child: ImageNetwork(url: "nothing"),
      //           ),
      //           const Gap(5),
      //           Text(
      //             "${controller.karyawan.name}",
      //             style: normalTextStyle.copyWith(
      //               fontWeight: medium,
      //               fontSize: 18,
      //             ),
      //           ),
      //           Text(
      //             "${controller.karyawan.jabatan}",
      //             style: normalTextStyle.copyWith(
      //               color: darkGreyColor,
      //               fontWeight: regular,
      //               fontSize: 12,
      //             ),
      //           ),
      //           const Gap(15),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Container(
      //                 decoration: BoxDecoration(
      //                   shape: BoxShape.circle,
      //                   color: whiteColor,
      //                 ),
      //                 padding: const EdgeInsets.all(10),
      //                 child: HeroIcon(HeroIcons.phone),
      //               ),
      //               const Gap(10),
      //               Container(
      //                 decoration: BoxDecoration(
      //                   shape: BoxShape.circle,
      //                   color: whiteColor,
      //                 ),
      //                 padding: const EdgeInsets.all(10),
      //                 child: HeroIcon(HeroIcons.chatBubbleLeftEllipsis),
      //               ),
      //             ],
      //           )
      //         ],
      //       ),
      //     ),
      //     Divider(thickness: 1, height: 0, color: darkGreyColor),
      //     _CustomInformations(
      //       title: "Cabang",
      //       subTitle: "${controller.karyawan.cabang}",
      //     ),
      //     _CustomInformations(
      //       title: "ID Karyawan",
      //       subTitle: "${controller.karyawan.id}",
      //     ),
      //     _CustomInformations(
      //       title: "Posisi pekerjaan",
      //       subTitle: "${controller.karyawan.posisiKaryawan}",
      //     ),
      //     _CustomInformations(
      //       title: "Nama Organisasi",
      //       subTitle: "${controller.karyawan.namaOrganisasi}",
      //     ),
      //   ],
      // ),
    );
  }
}

class InformationDetails extends StatelessWidget {
  const InformationDetails({
    super.key,
    required this.title,
    required this.subTilte,
  });

  final String title;
  final String subTilte;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: normalTextStyle.copyWith(
            fontSize: 12,
            fontWeight: regular,
            color: darkGreyColor,
          ),
        ),
        const Gap(5),
        Text(
          subTilte,
          style: normalTextStyle.copyWith(fontSize: 16, fontWeight: bold),
        ),
      ],
    );
  }
}

class TileInformations extends StatelessWidget {
  const TileInformations({
    super.key,
    required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.pink.shade50,
      ),
      child: Text(
        value,
        style: GoogleFonts.nunito(
          color: Colors.pink,
          fontSize: 12,
        ),
      ),
    );
  }
}

class CustomInformations extends StatelessWidget {
  const CustomInformations({
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
