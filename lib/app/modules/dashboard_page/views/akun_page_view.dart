import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:talenta_app/app/controllers/authentication_controller.dart';
import 'package:talenta_app/app/controllers/version_controller.dart';
import 'package:talenta_app/app/modules/akun_services/info_saya/views/file_saya_view.dart';
import 'package:talenta_app/app/modules/akun_services/info_saya/views/info_keluarga_view_view.dart';
import 'package:talenta_app/app/modules/akun_services/info_saya/views/info_kontak_darurat_view.dart';
import 'package:talenta_app/app/modules/akun_services/info_saya/views/info_payroll_view.dart';
import 'package:talenta_app/app/modules/akun_services/info_saya/views/peringatan_view.dart';
import 'package:talenta_app/app/modules/akun_services/pengaturan/views/pin_view.dart';
import 'package:talenta_app/app/modules/akun_services/pengaturan/views/ubah_kata_sandi_view.dart';

import 'package:talenta_app/app/shared/theme.dart';
import 'package:talenta_app/app/shared/utils.dart';

import '../../akun_services/info_saya/info_pekerjaan_view.dart';
import '../../akun_services/info_saya/info_personal_page_view.dart';

class AkunPageView extends StatefulWidget {
  const AkunPageView({super.key});

  @override
  State<AkunPageView> createState() => _AkunPageViewState();
}

class _AkunPageViewState extends State<AkunPageView> {
  var authC = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 10),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${authC.data.value!.data.user.nama}',
                      style: blackTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "${authC.jabatan.value}",
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: darkGreyColor,
                      ),
                    ),
                    Text(
                      "Andi Offset",
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: darkGreyColor,
                      ),
                    )
                  ],
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: darkGreyColor,
                  child: (authC.data.value!.data.user.avatar!.isEmpty)
                      ? Icon(Iconsax.user, color: whiteColor)
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            "${authC.data.value!.data.user.avatar}",
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Iconsax.user,
                              color: Colors.white,
                            ),
                            loadingBuilder: (context, child, loadingProgress) =>
                                loadingProgress == null
                                    ? child
                                    : Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: CircularProgressIndicator(),
                                      ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: Get.width,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Info Saya",
                  style: blackTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 18,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfoPersonalPageView(),
                  ),
                ),
                child: ListTileInfo(
                  Icon(Iconsax.user),
                  "Info personal",
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfoPekerjaanView(),
                  ),
                ),
                child: ListTileInfo(
                  Icon(Iconsax.personalcard),
                  "Info pekerjaan",
                ),
              ),
              GestureDetector(
                onTap: () => Get.to(
                  InfoKontakDaruratView(),
                  transition: Transition.fade,
                ),
                child: ListTileInfo(
                  Icon(Iconsax.information),
                  "Info kontak darurat",
                ),
              ),
              GestureDetector(
                onTap: () => Get.to(
                  InfoKeluargaViewView(),
                  transition: Transition.cupertino,
                ),
                child: ListTileInfo(
                  Icon(Iconsax.people),
                  "Info keluarga",
                ),
              ),
              // ListTileInfo(
              //   Icon(Icons.school_outlined),
              //   "Pendidikan dan pengalaman",
              // ),
              GestureDetector(
                onTap: () => Get.to(InfoPayrollView()),
                child: ListTileInfo(
                  Icon(Iconsax.wallet),
                  "Info payroll",
                ),
              ),
              GestureDetector(
                onTap: () => Get.to(FileSayaView()),
                child: ListTileInfo(
                  Icon(Icons.folder_copy_outlined),
                  "File saya",
                ),
              ),
              GestureDetector(
                onTap: () => Get.to(
                  PeringatanView(),
                  transition: Transition.downToUp,
                ),
                child: ListTileInfo(
                  Icon(Iconsax.danger),
                  "Peringatan",
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: Get.width,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Pengaturan",
                  style: blackTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 18,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UbahKataSandiView(),
                  ),
                ),
                child: ListTileInfo(
                  Icon(Iconsax.lock),
                  "Ubah kata sandi",
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PinView(),
                  ),
                ),
                child: ListTileInfo(
                  Icon(Iconsax.code_circle),
                  "PIN",
                ),
              ),
              Obx(
                () => (authC.isNeededPinWhenOpenApps.value)
                    ? ListTile(
                        leading: Icon(Icons.fingerprint),
                        title: Text(
                          "Aktifkan otentikasi",
                          style: GoogleFonts.outfit(
                            fontWeight: light,
                          ),
                        ),
                        trailing: Switch(
                          activeColor: darkBlueColor,
                          value: authC.isAuthenticationOn.value,
                          onChanged: (value) {
                            setState(() {
                              authC.initializedValidatorAuthentication();
                            });
                          },
                        ),
                      )
                    : SizedBox(),
              ),
            ],
          ),
        ),
        const Gap(10),
        Container(
          width: Get.width,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Lainnya",
                  style: blackTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 18,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Utils().exitRequestDialog(),
                child: ListTileInfo(Icon(Iconsax.logout), "Keluar"),
              ),
            ],
          ),
        ),
        const Gap(10),
        FutureBuilder(
          future: Get.put(VersionController()).androidAppsVersion(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                "version ${snapshot.data}",
                textAlign: TextAlign.center,
                style: blueTextStyle.copyWith(
                  fontSize: 16,
                ),
              );
            }
            return Container();
          },
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  ListTile ListTileInfo(leading, title) {
    return ListTile(
      leading: leading,
      title: Text(
        title,
        style: GoogleFonts.outfit(
          fontWeight: light,
        ),
      ),
      trailing: Icon(Icons.navigate_next_outlined),
    );
  }
}
