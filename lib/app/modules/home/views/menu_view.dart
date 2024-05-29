import 'package:flutter/material.dart';

import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:talenta_app/app/modules/home/controllers/home_controller.dart';
import 'package:talenta_app/app/modules/home/views/home_view.dart';
import 'package:talenta_app/app/modules/home/views/karyawan_view.dart';
import 'package:talenta_app/app/modules/home/views/notification_view.dart';
import 'package:talenta_app/app/modules/home/views/setting_view.dart';

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
                  selectedIcon: Image.asset(
                    "assets/icons/ic_home.png",
                    color: Colors.blue,
                  ),
                  icon: Image.asset(
                    "assets/icons/ic_home.png",
                    color: Colors.black38,
                  ),
                  selectedTitle: Text(
                    "Home",
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: Colors.blue,
                    ),
                  ),
                  title: Text(
                    "Home",
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: Colors.black38,
                    ),
                  ),
                ),
                if (controller.m.u.value!.manager == "1")
                  CustomNavigationBarItem(
                    selectedIcon: Image.asset(
                      "assets/icons/ic_team.png",
                      color: Colors.blue,
                    ),
                    icon: Image.asset(
                      "assets/icons/ic_team.png",
                      color: Colors.grey,
                    ),
                    selectedTitle: Text(
                      "Karyawan",
                      style:
                          GoogleFonts.outfit(fontSize: 14, color: Colors.blue),
                    ),
                    title: Text(
                      "Karyawan",
                      style: GoogleFonts.outfit(
                          fontSize: 14, color: Colors.black38),
                    ),
                  ),
                CustomNavigationBarItem(
                  selectedIcon: Image.asset(
                    "assets/icons/ic_inbox.png",
                    color: Colors.blue,
                  ),
                  icon: Image.asset(
                    "assets/icons/ic_inbox.png",
                    color: Colors.black38,
                  ),
                  selectedTitle: Text(
                    "Inbox",
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: Colors.blue,
                    ),
                  ),
                  title: Text(
                    "Inbox",
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: Colors.black38,
                    ),
                  ),
                ),
                CustomNavigationBarItem(
                  selectedIcon: Image.asset(
                    "assets/icons/ic_settings.png",
                    color: Colors.blue,
                  ),
                  icon: Image.asset(
                    "assets/icons/ic_settings.png",
                    color: Colors.black38,
                  ),
                  selectedTitle: Text(
                    "Setting",
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: Colors.blue,
                    ),
                  ),
                  title: Text(
                    "Setting",
                    style: GoogleFonts.outfit(
                      fontSize: 14,
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
