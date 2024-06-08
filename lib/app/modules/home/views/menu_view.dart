import 'package:flutter/material.dart';

import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';

import 'package:talenta_app/app/modules/home/controllers/home_controller.dart';
import 'package:talenta_app/app/modules/home/views/home_view.dart';
import 'package:talenta_app/app/modules/home/views/karyawan_view.dart';
import 'package:talenta_app/app/modules/home/views/notification_view.dart';
import 'package:talenta_app/app/modules/home/views/setting_view.dart';

import '../../../shared/theme.dart';

class MenuView extends GetView<HomeController> {
  MenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController());
    // List<Widget> widget = [HomeView(), KaryawanView(), NotificationView(), SettingView()];
    RxList<Widget> widget = <Widget>[
      HomeView(),
      if (controller.u.manager == "1") KaryawanView(),
      NotificationView(),
      SettingView(),
    ].obs;

    return Scaffold(
      body: Obx(() => widget[controller.btmNavIndex.value]),
      bottomNavigationBar: Obx(
        () => SizedBox(
          height: 65,
          child: CustomNavigationBar(
              iconSize: 19.0,
              blurEffect: true,
              backgroundColor: Colors.white.withOpacity(0.1),
              elevation: 0,
              currentIndex: controller.btmNavIndex.value,
              onTap: (value) => controller.btmNavIndex(value),
              items: [
                CustomNavigationBarItem(
                  icon: HeroIcon(HeroIcons.home),
                  selectedTitle: Text(
                    "Home",
                    style: GoogleFonts.quicksand(
                      fontWeight: medium,
                      fontSize: 12,
                      color: Colors.blue,
                    ),
                  ),
                  title: Text(
                    "Home",
                    style: GoogleFonts.quicksand(
                      fontWeight: medium,
                      fontSize: 12,
                      color: Colors.black38,
                    ),
                  ),
                ),
                if (controller.m.u.value!.manager == "1")
                  CustomNavigationBarItem(
                    icon: HeroIcon(HeroIcons.userGroup),
                    selectedTitle: Text(
                      "Karyawan",
                      style: GoogleFonts.quicksand(
                          fontWeight: medium, fontSize: 12, color: Colors.blue),
                    ),
                    title: Text(
                      "Karyawan",
                      style: GoogleFonts.quicksand(
                          fontWeight: medium,
                          fontSize: 12,
                          color: Colors.black38),
                    ),
                  ),
                CustomNavigationBarItem(
                  icon: HeroIcon(HeroIcons.inbox),
                  selectedTitle: Text(
                    "Inbox",
                    style: GoogleFonts.quicksand(
                      fontWeight: medium,
                      fontSize: 12,
                      color: Colors.blue,
                    ),
                  ),
                  title: Text(
                    "Inbox",
                    style: GoogleFonts.quicksand(
                      fontWeight: medium,
                      fontSize: 12,
                      color: Colors.black38,
                    ),
                  ),
                ),
                CustomNavigationBarItem(
                  icon: HeroIcon(HeroIcons.cog6Tooth),
                  selectedTitle: Text(
                    "Setting",
                    style: GoogleFonts.quicksand(
                      fontWeight: medium,
                      fontSize: 12,
                      color: Colors.blue,
                    ),
                  ),
                  title: Text(
                    "Setting",
                    style: GoogleFonts.quicksand(
                      fontWeight: medium,
                      fontSize: 12,
                      color: Colors.black38,
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
