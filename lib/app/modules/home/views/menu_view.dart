import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:talenta_app/app/modules/home/controllers/home_controller.dart';
import 'package:talenta_app/app/modules/home/views/home_view.dart';
import 'package:talenta_app/app/modules/home/views/karyawan_view.dart';
import 'package:talenta_app/app/modules/home/views/notification_view.dart';
import 'package:talenta_app/app/modules/home/views/setting_view.dart';
import 'package:talenta_app/app/shared/theme.dart';

class MenuView extends GetView<HomeController> {
  MenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController());
    // List<Widget> widget = [HomeView(), KaryawanView(), NotificationView(), SettingView()];
    RxList<Widget> widget = <Widget>[
      HomeView(),
      if (controller.u.user.manager == "1") KaryawanView(),
      NotificationView(),
      SettingView(),
    ].obs;

    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Obx(() => widget[controller.btmNavIndex.value]),
      bottomNavigationBar: Obx(
        () => CustomNavigationBar(
            currentIndex: controller.btmNavIndex.value,
            onTap: (value) => controller.btmNavIndex(value),
            items: [
              CustomNavigationBarItem(
                selectedIcon: Icon(
                  Iconsax.home_2,
                  color: Colors.blue,
                ),
                icon: Icon(
                  Iconsax.home_2,
                  color: Colors.black38,
                ),
                selectedTitle: Text(
                  "Home",
                  style: normalTextStyle.copyWith(color: Colors.blue),
                ),
                title: Text(
                  "Home",
                  style: normalTextStyle.copyWith(color: Colors.black38),
                ),
              ),
              if (controller.m.u.value.user.manager == "1")
                CustomNavigationBarItem(
                  selectedIcon: Icon(
                    Iconsax.people,
                    color: Colors.blue,
                  ),
                  icon: Icon(
                    Iconsax.people,
                    color: Colors.black38,
                  ),
                  selectedTitle: Text(
                    "Employee",
                    style: normalTextStyle.copyWith(color: Colors.blue),
                  ),
                  title: Text(
                    "Employee",
                    style: normalTextStyle.copyWith(color: Colors.black38),
                  ),
                ),
              CustomNavigationBarItem(
                selectedIcon: Icon(
                  Iconsax.message,
                  color: Colors.blue,
                ),
                icon: Icon(
                  Iconsax.message,
                  color: Colors.black38,
                ),
                selectedTitle: Text(
                  "Inbox",
                  style: normalTextStyle.copyWith(
                    color: Colors.blue,
                  ),
                ),
                title: Text(
                  "Inbox",
                  style: normalTextStyle.copyWith(
                    color: Colors.black38,
                  ),
                ),
              ),
              CustomNavigationBarItem(
                selectedIcon: Icon(
                  Iconsax.personalcard,
                  color: Colors.blue,
                ),
                icon: Icon(
                  Iconsax.personalcard,
                  color: Colors.black38,
                ),
                selectedTitle: Text(
                  "Settings",
                  style: normalTextStyle.copyWith(
                    color: Colors.blue,
                  ),
                ),
                title: Text(
                  "Settings",
                  style: normalTextStyle.copyWith(
                    color: Colors.black38,
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
