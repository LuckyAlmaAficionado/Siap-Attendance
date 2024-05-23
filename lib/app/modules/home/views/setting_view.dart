import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:talenta_app/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:talenta_app/app/modules/home/controllers/home_controller.dart';
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            Colors.blue.shade100,
            Colors.blue.shade100,
            Colors.blue.shade100,
            Colors.white,
            Colors.white,
            Colors.white,
          ],
        ),
      ),
      child: ListView(
        children: [
          const SizedBox(height: 10),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: context.width * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${controller.u.user.nama}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: blackTextStyle.copyWith(
                            fontWeight: semiBold,
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
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: darkGreyColor,
                    child: (controller.u.user.avatar!.isEmpty)
                        ? Icon(Iconsax.user, color: whiteColor)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              "${controller.u.user.avatar}",
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                Iconsax.user,
                                color: Colors.white,
                              ),
                              loadingBuilder: (context, child,
                                      loadingProgress) =>
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
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Material(
              elevation: 1,
              color: whiteColor,
              borderRadius: BorderRadius.circular(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Info Saya",
                      style: blackTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  GestureDetector(
                    // onTap: () => Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => InfoPersonalPageView(),
                    //   ),
                    // ),
                    child: ListTileInfo(
                      Icon(Iconsax.user),
                      "Info personal",
                    ),
                  ),
                  GestureDetector(
                    // onTap: () => Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => InfoPekerjaanView(),
                    //   ),
                    // ),
                    child: ListTileInfo(
                      Icon(Iconsax.personalcard),
                      "Info pekerjaan",
                    ),
                  ),
                  GestureDetector(
                    // onTap: () => Get.to(
                    //   InfoKontakDaruratView(),
                    //   transition: Transition.fade,
                    // ),
                    child: ListTileInfo(
                      Icon(Iconsax.information),
                      "Info kontak darurat",
                    ),
                  ),
                  GestureDetector(
                    // onTap: () => Get.to(
                    //   InfoKeluargaViewView(),
                    //   transition: Transition.cupertino,
                    // ),
                    child: ListTileInfo(
                      Icon(Iconsax.people),
                      "Info keluarga",
                    ),
                  ),
                  GestureDetector(
                    // onTap: () => Get.to(InfoPayrollView()),
                    child: ListTileInfo(
                      Icon(Iconsax.wallet),
                      "Info payroll",
                    ),
                  ),
                  GestureDetector(
                    // onTap: () => Get.to(FileSayaView()),
                    child: ListTileInfo(
                      Icon(Iconsax.folder),
                      "File saya",
                    ),
                  ),
                  GestureDetector(
                    // onTap: () => Get.to(
                    //   PeringatanView(),
                    //   transition: Transition.downToUp,
                    // ),
                    child: ListTileInfo(
                      Icon(Iconsax.danger),
                      "Peringatan",
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Gap(5),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Material(
              color: whiteColor,
              borderRadius: BorderRadius.circular(5),
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
                      prefixIcon: Iconsax.lock_1,
                      suffixIcon: Iconsax.arrow_right_3,
                    ),
                    ListTile1(
                      title: 'PIN',
                      prefixIcon: Iconsax.code,
                      suffixIcon: Iconsax.arrow_right_3,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Gap(5),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Material(
              color: whiteColor,
              borderRadius: BorderRadius.circular(5),
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
                      prefixIcon: Iconsax.logout,
                      suffixIcon: Iconsax.arrow_right_3,
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
                    color: blackColor,
                    fontSize: 16,
                  ),
                );
              }
              return Container();
            },
          ),
          const SizedBox(height: 20),
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
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color? colors;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      onTap: onTap,
      leading: prefixIcon != null
          ? Icon(
              prefixIcon,
              color: colors ?? darkGreyColor,
            )
          : null,
      title: Text(
        title,
        style: normalTextStyle.copyWith(
          fontWeight: light,
          color: colors ?? blackColor,
        ),
      ),
      trailing: suffixIcon != null
          ? Icon(
              suffixIcon,
              color: colors ?? darkGreyColor,
            )
          : null,
    );
  }
}
