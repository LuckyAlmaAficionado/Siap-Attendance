import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import 'package:talenta_app/app/controllers/authentication_controller.dart';
import 'package:talenta_app/app/controllers/date_controller.dart';
import 'package:talenta_app/app/models/google_calendar.dart';
import 'package:talenta_app/app/shared/theme.dart';

import '../../../routes/app_pages.dart';
import '../controllers/dashboard_page_controller.dart';

// ignore: must_be_immutable
class NewHomePageView extends GetView {
  NewHomePageView({Key? key}) : super(key: key);
  final controller = Get.put(DashboardPageController());
  AuthenticationController authC = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await authC.fetchDataAbsensi(authC.data.value!.data.user.id!);
          await authC.fetchDetailAbsensi();
        },
        child: ListView(
          children: [
            KehadiranAbsen(controller: controller),
            FiturServices(controller: controller),
            PanelAbsensi(controller: controller),
          ],
        ),
      ),
    );
  }
}

class PanelAbsensi extends StatelessWidget {
  const PanelAbsensi({
    super.key,
    required this.controller,
  });

  final DashboardPageController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: Get.width,
        child: Material(
          borderRadius: BorderRadius.circular(10),
          elevation: 5,
          child: Column(
            children: [
              (controller.authC.clockInEntry.value == null ||
                      controller.authC.clockOutEntry.value == null)
                  ? Container(
                      width: Get.width,
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: lightGreyColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Iconsax.danger, color: Colors.red),
                          const Gap(10),
                          RichText(
                            text: TextSpan(
                              text: "Anda belum ",
                              style: blackTextStyle,
                              children: [
                                TextSpan(
                                  text: (controller.authC.clockInEntry.value ==
                                          null)
                                      ? "clock in"
                                      : "clock out",
                                  style: blackTextStyle.copyWith(
                                      fontWeight: semiBold),
                                ),
                                TextSpan(
                                  text: " hari ini.",
                                  style: blackTextStyle,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(),
              Container(
                width: Get.width,
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jadwal: ${DateFormat("d MMM yyyy", "id_ID").format(DateTime.now())}",
                      style: darkGreyTextStyle,
                    ),
                    const Gap(5),
                    Text(
                      "${DateFormat("HH:MM").format(DateTime.now())} WIB - ${DateFormat("HH:MM").format(DateTime.now().add(Duration(minutes: 840)))} WIB",
                      style: blackTextStyle.copyWith(
                        fontWeight: bold,
                        fontSize: 14.5,
                      ),
                    ),
                    const Gap(10),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () async => controller.clockInAbsensi(),
                            child: Text(
                              "Clock-In",
                              style:
                                  whiteTextStyle.copyWith(fontWeight: medium),
                            ),
                          ),
                        ),
                        const Gap(15),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () async => controller.clockOutAbsensi(),
                            child: Text(
                              "Clock-Out",
                              style:
                                  whiteTextStyle.copyWith(fontWeight: medium),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FiturAbsensi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: Get.width,
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: whiteColor,
              border: Border.all(
                width: 1,
                color: darkBlueColor,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          Routes.LOCATIONS_PAGE,
                          arguments: "Absen Masuk",
                        );
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/ic_sign_in.png',
                              height: 30,
                              width: 30,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Absen Masuk',
                              style: blackTextStyle.copyWith(
                                fontWeight: semiBold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 0.5,
                    height: constraints.maxHeight,
                    color: darkGreyColor,
                  ),
                  // INFO: CLOCK OUT
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          Routes.LOCATIONS_PAGE,
                          arguments: "Absen Keluar",
                        );
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/ic_sign_out.png',
                              height: 33,
                              width: 33,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Absen Keluar',
                              style: blackTextStyle.copyWith(
                                fontWeight: semiBold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class KehadiranAbsen extends StatelessWidget {
  const KehadiranAbsen({
    super.key,
    required this.controller,
  });

  final DashboardPageController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.developer_board,
                    color: blackColor,
                  ),
                  const Gap(10),
                  Text(
                    "SIAP",
                    style: blackTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () =>
                        (controller.authC.data.value!.data.user.superAdmin ==
                                "1")
                            ? controller.selectedIndex.value = 2
                            : controller.selectedIndex.value = 1,
                    icon: Icon(
                      Iconsax.notification,
                      color: blackColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  // Profile Picture
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: darkGreyColor.withAlpha(200),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: (controller
                              .authC.data.value!.data.user.avatar!.isEmpty)
                          ? Icon(Iconsax.user, color: Colors.white)
                          : Image.network(
                              "${controller.authC.data.value!.data.user.avatar}",
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                Icons.person,
                                color: whiteColor,
                              ),
                              loadingBuilder: (context, child,
                                      loadingProgress) =>
                                  loadingProgress == null
                                      ? child
                                      : Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: CircularProgressIndicator(),
                                        ),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),

                  // Detail information
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    width: Get.width * 0.45,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${controller.authC.data.value!.data.user.nama}",
                          overflow: TextOverflow.ellipsis,
                          style: blackTextStyle.copyWith(
                            fontWeight: medium,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${controller.authC.jabatan.value}",
                          overflow: TextOverflow.ellipsis,
                          style: blackTextStyle.copyWith(
                            fontWeight: extraLight,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ),
                  new Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat("HH:mm", "id_ID").format(DateTime.now()),
                          style: blackTextStyle.copyWith(
                            fontWeight: semiBold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "${DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now())}",
                          style: blackTextStyle.copyWith(
                            fontWeight: regular,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Gap(15),
            Pengumuman(),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}

class FiturServices extends StatelessWidget {
  const FiturServices({
    super.key,
    required this.controller,
  });

  final DashboardPageController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.DAFTAR_ABSENSI_PAGE),
                    child: IconWidgetService(
                      Iconsax.calendar,
                      "Daftar Absen",
                      HexColor("FA7113"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.ABSEN_PAGE),
                    child: IconWidgetService(
                      Iconsax.location,
                      "Absen",
                      HexColor("FC9E13"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.TELAT_MASUK_PAGE),
                    child: IconWidgetService(
                      Iconsax.watch,
                      "Istirahat Telat",
                      HexColor("18B8A6"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.CUTI_PAGE),
                    child: IconWidgetService(
                      Iconsax.briefcase,
                      "Cuti",
                      HexColor("3883F7"),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  (controller.authC.data.value!.data.user.superAdmin!
                          .contains("1"))
                      ? GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.ANGGOTA_TIM);
                            // if (!controller.authC.jabatan!.nama!
                            //     .toLowerCase()
                            //     .contains("manager")) {
                            //   Utils().informationUtils(
                            //     'Akses diperlukan',
                            //     "Anda tidak memiliki akses untuk fitur ini",
                            //     false,
                            //   );
                            //   return;
                            // }
                            // Get.toNamed(Routes.ANGGOTA_TIM);
                          },
                          child: IconWidgetService(
                            Iconsax.user,
                            "Tim Anda",
                            HexColor("3883F7"),
                          ),
                        )
                      : SizedBox(),
                  GestureDetector(
                    onTap: () =>
                        (controller.authC.isNeededPinWhenOpenApps.value)
                            ? Get.toNamed(
                                Routes.VALIDATOR_PIN,
                                arguments: "slip-gaji",
                              )
                            : Get.toNamed(Routes.SLIP_GAJI_PAGE),
                    child: IconWidgetService(
                      Iconsax.wallet,
                      "Slip Gaji",
                      HexColor("18B8A6"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.servicePengajuan(context),
                    child: IconWidgetService(
                      Iconsax.task_square,
                      "Pengajuan",
                      HexColor("7D4DFD"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.IZIN_KEMBALI_PAGE),
                    child: IconWidgetService(
                      Iconsax.refresh,
                      "Izin Kembali",
                      HexColor("FA7113"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Pengumuman extends StatelessWidget {
  Pengumuman({super.key});

  final holidayC = Get.put(DateController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Column(
        children: [
          const Gap(10),
          Container(
              width: Get.width,
              height: 140,
              child: FutureBuilder(
                future: holidayC.filterMonthAndYear(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CarouselSlider(
                      options: CarouselOptions(enlargeCenterPage: true),
                      items: List.generate(
                        4,
                        (index) => Container(
                          width: 320,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: ListView.builder(
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 310,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    List<GoogleCalendarModel> result = snapshot.data;

                    return CarouselSlider(
                        items: List.generate(result.length, (index) {
                          GoogleCalendarModel model = result[index];

                          return GestureDetector(
                            onTap: () => Get.toNamed(Routes.DETAIL_PENGUMUMAN),
                            child: Container(
                              width: 320,
                              decoration: BoxDecoration(
                                color: (index % 2 == 0 && index == 0)
                                    ? darkGreyColor
                                    : Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    width: Get.width,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(
                                            0.2,
                                          ),
                                          BlendMode.darken,
                                        ),
                                        child: Image.network(
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Icon(
                                            Icons.image,
                                            color: whiteColor,
                                          ),
                                          filterQuality: FilterQuality.high,
                                          loadingBuilder: (context, child,
                                                  loadingProgress) =>
                                              loadingProgress == null
                                                  ? child
                                                  : CircularProgressIndicator(),
                                          "https://static.vecteezy.com/system/resources/previews/024/552/492/non_2x/eid-al-adha-greetings-banner-selamat-hari-raya-idul-adha-means-happy-eid-mubarak-banner-design-vector.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          model.summary,
                                          style: whiteTextStyle.copyWith(
                                            fontWeight: semiBold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const Gap(5),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.event_available_outlined,
                                              color: whiteColor,
                                            ),
                                            const Gap(7),
                                            Text(
                                              "${DateFormat("dd MMMM yyyy", "id_ID").format(model.start.date)}",
                                              style: whiteTextStyle.copyWith(
                                                fontWeight: extraLight,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                        ));
                  }

                  return Container(child: Text("ERROR BANG"));
                },
              ))
        ],
      ),
    );
  }
}

class biodataPengguna extends StatelessWidget {
  const biodataPengguna({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 25,
            ),

            // Detail information
            Container(
              margin: const EdgeInsets.only(left: 10),
              width: Get.width * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Lucky Alma Aficionado Rigel",
                    overflow: TextOverflow.ellipsis,
                    style: blackTextStyle.copyWith(
                      fontWeight: regular,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Programmer",
                    overflow: TextOverflow.ellipsis,
                    style: darkGreyTextStyle.copyWith(
                      fontWeight: extraLight,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ),
            new Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_outlined),
            ),
          ],
        ),
      ),
    );
  }
}

Container IconWidgetService(IconData icons, String title, Color colors) {
  return Container(
    width: 80,
    height: 90,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(100),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(shape: BoxShape.circle, color: colors),
            child: Icon(icons, size: 25, color: whiteColor),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: blackTextStyle.copyWith(fontSize: 11, fontWeight: regular),
        ),
      ],
    ),
  );
}
