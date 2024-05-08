import 'package:flutter/material.dart';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:talenta_app/app/modules/dashboard_page/views/akun_page_view.dart';
import 'package:talenta_app/app/modules/dashboard_page/views/dashboard_view.dart';
import 'package:talenta_app/app/modules/dashboard_page/views/inbox_page_view.dart';
import 'package:talenta_app/app/modules/dashboard_page/views/karyawan_page_view.dart';
import 'package:talenta_app/app/shared/more_services.dart';
import 'package:talenta_app/app/shared/theme.dart';

import '../controllers/dashboard_page_controller.dart';

// ignore: must_be_immutable
class DashboardPageView extends GetView<DashboardPageController> {
  @override
  Widget build(BuildContext context) {
    // ... cek apakah dari super admin
    var listWidget = <Widget>[
      // HomePageView(),
      NewHomePageView(),
      if (controller.authC.data.value!.data.user.superAdmin == "1")
        KaryawanPageView(),
      InboxPageView(),
      AkunPageView(),
    ].obs;

    // ...
    return Scaffold(
      body: Obx(() => listWidget[controller.selectedIndex.value]),
      floatingActionButton: _floatingActionButton(context),
      floatingActionButtonLocation: _floatingActionButtonLocation(),
      bottomNavigationBar: _bottomNavBar(),
    );
  }

  _floatingActionButton(BuildContext context) => FloatingActionButton(
        onPressed: () async => _showMoreServices(context),
        child: Icon(Iconsax.more_square),
      );

  _showMoreServices(BuildContext context) =>
      showDialog(context: context, builder: (context) => MoreServices());

  _floatingActionButtonLocation() =>
      (controller.authC.data.value!.data.user.superAdmin == "1")
          ? FloatingActionButtonLocation.centerDocked
          : FloatingActionButtonLocation.endFloat;

  _bottomNavBar() => Obx(
        () => AnimatedBottomNavigationBar(
          height: 70,
          icons: [
            Iconsax.home,
            if (controller.authC.data.value!.data.user.superAdmin == "1")
              Iconsax.user_search,
            Iconsax.notification,
            Iconsax.personalcard,
          ],
          splashRadius: 20,
          splashColor: blueColor,
          activeColor: blueColor,
          inactiveColor: Colors.grey,
          gapLocation:
              (controller.authC.data.value!.data.user.superAdmin == "1")
                  ? GapLocation.center
                  : GapLocation.none,
          activeIndex: controller.selectedIndex.value,
          onTap: (index) => controller.selectedIndex(index),
        ),
      );
}
