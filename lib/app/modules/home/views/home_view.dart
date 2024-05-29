// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import 'package:talenta_app/app/controllers/model_controller.dart';
import 'package:talenta_app/app/shared/button/button_1.dart';
import 'package:talenta_app/app/shared/images/images.dart';
import 'package:talenta_app/app/shared/more_services.dart';
import 'package:talenta_app/app/shared/theme.dart';
import 'package:talenta_app/app/shared/utils.dart';

import '../../../controllers/date_controller.dart';
import '../../../models/google_calendar.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController());
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Container(
        decoration: BoxDecoration(),
        child: RefreshIndicator(
          onRefresh: controller.onRefresh,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                floating: true,
                automaticallyImplyLeading: false,
                title: Container(
                  margin: const EdgeInsets.only(top: 15),
                  width: context.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 45,
                        height: 45,
                        child: ImageNetwork(url: controller.u.avatar!),
                      ),
                      const Gap(10),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${controller.u.nama}",
                              style: normalTextStyle,
                            ),
                            Text(
                              "${controller.u.jabatan}",
                              style: normalTextStyle.copyWith(
                                fontSize: 12,
                                color: darkGreyColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Spacer(),
                      IconButton(
                        onPressed: () async {
                          await controller.a.getLocations();
                          // Get.put(CaptureAttendanceController()).loadImage(
                          //     "1c913910-21d8-1ff6-a458-8b8bb778ddf1.jpg");
                        },
                        icon: Icon(Iconsax.notification, color: Colors.black54),
                      )
                    ],
                  ),
                ),
                backgroundColor: whiteColor,
                stretch: true,
                expandedHeight: 85.0,
                toolbarHeight: 70,
                collapsedHeight: 80,
              ),
              SliverToBoxAdapter(
                child: Obx(
                  () => Column(
                    children: [
                      Announcement(),
                      const Gap(15),
                      ServiceWidget(),
                      FutureBuilder(
                        future: controller.validatorIzin(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            bool v = snapshot.data;
                            print(v);
                            if (v) {
                              return Column(
                                children: [
                                  const Gap(15),
                                  PanelIzin(),
                                ],
                              );
                            } else {
                              return SizedBox();
                            }
                          }
                          return Container();
                        },
                      ),
                      const Gap(15),
                      PanelAbsensi(),
                      const Gap(20),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Announcement extends StatelessWidget {
  Announcement({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: 160,
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: CarouselSlider(
              items: List.generate(
                3,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(),
                  child: ImageNetwork(
                    borderRadius: 0,
                    url:
                        "https://t4.ftcdn.net/jpg/05/57/46/03/360_F_557460386_dKs9K9peVkWWi6VpnMFIKGciQJzRyCX6.jpg",
                  ),
                ),
              ).toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                onPageChanged: (index, reason) => controller.curIndex(index),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 20,
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: (controller.curIndex == index)
                          ? Colors.white
                          : Colors.black.withOpacity(0.4),
                    ),
                    width: controller.curIndex == index ? 20 : 5,
                    height: 5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
          Container(
              width: Get.width,
              height: context.height * 0.22,
              child: FutureBuilder(
                future: holidayC.filterMonthAndYear(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CarouselSlider(
                      options: CarouselOptions(enlargeCenterPage: true),
                      items: List.generate(
                        4,
                        (index) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: context.height * 0.2,
                          width: 320,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: ListView.builder(
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: context.width * 0.75,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
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
                              height: context.height * 0.20,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: (index % 2 == 0 && index == 0)
                                    ? darkGreyColor
                                    : Colors.blue,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(10),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: Get.width,
                                      height: context.height * 0.22,
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
                                                    : Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                            "https://static.vecteezy.com/system/resources/previews/024/552/492/non_2x/eid-al-adha-greetings-banner-selamat-hari-raya-idul-adha-means-happy-eid-mubarak-banner-design-vector.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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

class PanelAbsensi extends StatelessWidget {
  PanelAbsensi({super.key});

  final m = Get.find<ModelController>();
  final a = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      width: Get.width,
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(15),
        color: whiteColor,
        child: Column(
          children: [
            (m.ci.value.id == null || m.co.value.id == null)
                ? Container(
                    width: Get.width,
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: lightGreyColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Iconsax.danger, color: Colors.red),
                        const Gap(5),
                        RichText(
                          text: TextSpan(
                            text: "Anda belum ",
                            style: normalTextStyle.copyWith(
                              fontSize: 12,
                            ),
                            children: [
                              TextSpan(
                                text: (m.ci.value.id == null)
                                    ? " Clock-In "
                                    : " Clock-Out ",
                                style: normalTextStyle.copyWith(
                                  fontWeight: semiBold,
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              ),
                              TextSpan(
                                text: " hari ini.",
                                style: normalTextStyle.copyWith(
                                  fontSize: 12,
                                ),
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
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Jadwal: ${DateFormat("d MMM yyyy", "id_ID").format(DateTime.now())}",
                    style: normalTextStyle.copyWith(
                        fontSize: 12, color: darkGreyColor),
                  ),
                  const Gap(5),
                  Text(
                    "${DateFormat("HH:MM").format(DateTime.now())} WIB - ${DateFormat("HH:MM").format(DateTime.now().add(Duration(minutes: 840)))} WIB",
                    style: normalTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 14,
                    ),
                  ),
                  const Gap(10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          child: Button1(
                            title: "Clock In",
                            onTap: () async => a.clockInAbsensi(),
                          ),
                        ),
                      ),
                      const Gap(5),
                      Expanded(
                        child: Container(
                          height: 40,
                          child: Button1(
                            title: "Clock Out",
                            onTap: () async => a.clockOutAbsensi(),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ServiceWidget extends StatelessWidget {
  ServiceWidget({
    super.key,
  });

  ModelController m = Get.find<ModelController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: context.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: whiteColor,
          ),
          padding: const EdgeInsets.all(0),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
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
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.SLIP_GAJI_PAGE);
                },
                child: IconWidgetService(
                  Iconsax.wallet,
                  "Slip Gaji",
                  HexColor("18B8A6"),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.dialog(MoreServices());
                },
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
              GestureDetector(
                onTap: () {
                  switch (m.u.value!.manager) {
                    case "1":
                      Get.toNamed(Routes.ANGGOTA_TIM);
                      break;
                    default:
                      Utils().informationUtils(
                        'Akses diperlukan',
                        "Anda tidak memiliki akses untuk fitur ini",
                        false,
                      );
                      break;
                  }
                },
                child: IconWidgetService(
                  Iconsax.people,
                  "Tim Anda",
                  HexColor("3883F7"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PanelIzin extends StatelessWidget {
  PanelIzin({super.key});

  final HomeController homeC = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      width: Get.width,
      child: Material(
        borderRadius: BorderRadius.circular(15),
        color: whiteColor,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: lightGreyColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Icon(Iconsax.danger, color: redColor),
                    const Gap(5),
                    Text(
                      "Anda belum izin kembali",
                      style: normalTextStyle.copyWith(
                        fontSize: 12,
                        color: blackColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 40,
                margin: const EdgeInsets.only(top: 15),
                width: context.width,
                child: Button1(
                  title: "Izin Kembali",
                  onTap: () => Get.toNamed(Routes.IZIN_KEMBALI_PAGE),
                ),
              )
            ],
          ),
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
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade100,
          ),
          child: Icon(
            icons,
            size: 23,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: blackTextStyle.copyWith(
            fontSize: 11,
            fontWeight: regular,
          ),
        ),
      ],
    ),
  );
}
