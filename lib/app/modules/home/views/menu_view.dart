import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:talenta_app/app/modules/home/controllers/home_controller.dart';

class MenuView extends GetView<HomeController> {
  MenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController());
    return Scaffold(
      body: Obx(() => controller.widget[controller.btmNavIndex.value]),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          onDestinationSelected: controller.changeBtmNavIndex,
          selectedIndex: controller.btmNavIndex.value,
          height: 80,
          elevation: 5,
          backgroundColor: Colors.white,
          destinations: const [
            NavigationDestination(
              icon: Icon(Iconsax.home_2),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Iconsax.people),
              label: "Karyawan",
            ),
            NavigationDestination(
              icon: Icon(Iconsax.notification),
              label: "Inbox",
            ),
            NavigationDestination(
              icon: Icon(Iconsax.setting),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
