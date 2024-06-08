import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:talenta_app/app/models/karyawan.dart';

import 'package:talenta_app/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:talenta_app/app/modules/authentication/views/pin_view.dart';
import 'package:talenta_app/app/modules/home/controllers/home_controller.dart';
import 'package:talenta_app/app/modules/settings/views/info_file_view.dart';
import 'package:talenta_app/app/modules/settings/views/info_payroll_view.dart';
import 'package:talenta_app/app/modules/settings/views/info_pekerjaan_view.dart';
import 'package:talenta_app/app/modules/settings/views/info_peringatan_view.dart';
import 'package:talenta_app/app/modules/settings/views/info_personal_view.dart';
import 'package:talenta_app/app/shared/images/images.dart';
import 'package:talenta_app/app/shared/theme.dart';

import '../../../controllers/version_controller.dart';
import '../../../shared/utils.dart';

// ignore: must_be_immutable
class SettingView extends GetView<HomeController> {
  SettingView({Key? key}) : super(key: key);

  String status = "remove-pin-code";

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AuthController());
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade100),
      child: ListView(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
                bottom: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: context.width * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${controller.u.nama}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: blackTextStyle.copyWith(
                            fontWeight: medium,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "${controller.u.jabatan}",
                          style: normalTextStyle.copyWith(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            color: darkGreyColor,
                          ),
                        ),
                        Text(
                          "Andi Offset",
                          style: normalTextStyle.copyWith(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            color: darkGreyColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: ImageNetwork(url: controller.u.avatar!),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Material(
              color: whiteColor,
              borderRadius: BorderRadius.circular(15),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Detail Informasi",
                      style: blackTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 18,
                      ),
                    ),
                    ListTile1(
                      onTap: () => Get.to(
                        InfoPersonalView(),
                        transition: Transition.cupertino,
                      ),
                      title: 'Info personal',
                      prefixIcon: HeroIcons.identification,
                      suffixIcon: HeroIcons.chevronRight,
                    ),
                    ListTile1(
                      onTap: () => Get.to(
                        InfoPekerjaanView(),
                        transition: Transition.cupertino,
                      ),
                      title: 'Info pekerjaan',
                      prefixIcon: HeroIcons.briefcase,
                      suffixIcon: HeroIcons.chevronRight,
                    ),
                    // ListTile1(
                    //   onTap: () => Get.to(
                    //     InfoKontakDaruratView(),
                    //     transition: Transition.cupertino,
                    //   ),
                    //   title: 'Info kontak darurat',
                    //   prefixIcon: HeroIcons.shieldCheck,
                    //   suffixIcon: HeroIcons.chevronRight,
                    // ),
                    // ListTile1(
                    //   onTap: () => Get.to(
                    //     InfoKeluargaView(),
                    //     transition: Transition.cupertino,
                    //   ),
                    //   title: 'Info keluarga',
                    //   prefixIcon: HeroIcons.userGroup,
                    //   suffixIcon: HeroIcons.chevronRight,
                    // ),
                    ListTile1(
                      onTap: () => Get.to(
                        InfoPayrollView(),
                        transition: Transition.cupertino,
                      ),
                      title: 'Info Payroll',
                      prefixIcon: HeroIcons.banknotes,
                      suffixIcon: HeroIcons.chevronRight,
                    ),
                    ListTile1(
                      onTap: () => Get.to(
                        InfoFileView(),
                        transition: Transition.cupertino,
                      ),
                      title: 'File saya',
                      prefixIcon: HeroIcons.folder,
                      suffixIcon: HeroIcons.chevronRight,
                    ),
                    ListTile1(
                      onTap: () => Get.to(
                        InfoPeringatanView(),
                        transition: Transition.cupertino,
                      ),
                      title: 'Peringatan',
                      prefixIcon: HeroIcons.exclamationTriangle,
                      suffixIcon: HeroIcons.chevronRight,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Gap(15),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Material(
              color: whiteColor,
              borderRadius: BorderRadius.circular(15),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pengaturan",
                      style: blackTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 18,
                      ),
                    ),
                    ListTile1(
                      title: 'Ubah kata sandi',
                      prefixIcon: HeroIcons.lockClosed,
                      suffixIcon: HeroIcons.chevronRight,
                    ),
                    Obx(() => ListTile1(
                          onTap: () => Get.to(
                            () => PinView(),
                            transition: Transition.cupertino,
                            arguments:
                                controller.m.pinC.isEmpty ? "" : "ubah-pin",
                          ),
                          title: controller.m.pinC.isEmpty ? "PIN" : "Ubah PIN",
                          prefixIcon: HeroIcons.key,
                          suffixIcon: HeroIcons.chevronRight,
                        )),
                    Obx(
                      () => (controller.m.pinC.isEmpty)
                          ? SizedBox()
                          : ListTile1(
                              title: "Matikan PIN",
                              onTap: () async {
                                Get.to(
                                  () => PinView(),
                                  arguments: "matikan-pin",
                                );
                              },
                              prefixIcon: HeroIcons.lockOpen,
                              suffixIcon: HeroIcons.chevronRight,
                            ),
                    ),
                    Obx(
                      () => (controller.m.pinC.isEmpty)
                          ? SizedBox()
                          : ListTile(
                              contentPadding: EdgeInsets.all(0),
                              leading: HeroIcon(HeroIcons.fingerPrint),
                              horizontalTitleGap: 0,
                              title: Text(
                                "Hidupkan Biometric",
                                style: normalTextStyle.copyWith(
                                  fontWeight: light,
                                  color: blackColor,
                                ),
                              ),
                              trailing: Switch(
                                value: true,
                                activeColor: Colors.pink.shade400,
                                onChanged: (value) {},
                              )),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Gap(15),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Material(
              color: whiteColor,
              borderRadius: BorderRadius.circular(15),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Logout",
                      style: blackTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 18,
                      ),
                    ),
                    ListTile1(
                      title: 'Keluar',
                      prefixIcon: HeroIcons.arrowRightEndOnRectangle,
                      suffixIcon: HeroIcons.chevronRight,
                      colors: redColor,
                      onTap: () => Get.dialog(AlertExit()),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Gap(5),
          FutureBuilder(
            future: Get.put(VersionController()).androidAppsVersion(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  "Version (${snapshot.data})",
                  textAlign: TextAlign.center,
                  style: normalTextStyle.copyWith(
                    color: darkGreyColor,
                    fontSize: 10,
                  ),
                );
              }
              return Container();
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  ListTile ListTileInfo(leading, title) {
    return ListTile(
      leading: leading,
      title: Text(
        title,
        style: normalTextStyle.copyWith(
          fontWeight: light,
        ),
      ),
      trailing: Icon(Icons.navigate_next_outlined),
    );
  }
}

class ListTile1 extends StatelessWidget {
  const ListTile1({
    super.key,
    required this.title,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    this.colors,
  });

  final String title;
  final Function()? onTap;
  final HeroIcons? prefixIcon;
  final HeroIcons? suffixIcon;
  final Color? colors;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      onTap: onTap,
      leading: prefixIcon != null
          ? HeroIcon(prefixIcon!, color: colors ?? darkGreyColor)
          : null,
      horizontalTitleGap: 0,
      title: Text(
        title,
        style: normalTextStyle.copyWith(
          fontWeight: light,
          color: colors ?? blackColor,
        ),
      ),
      trailing: suffixIcon != null
          ? HeroIcon(suffixIcon!, color: colors ?? darkGreyColor)
          : null,
    );
  }
}
