import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

import 'package:talenta_app/app/modules/home/controllers/home_controller.dart';
import 'package:talenta_app/app/shared/alert/alert-detail-inbox.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/theme.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView>
    with TickerProviderStateMixin {
  final controller = Get.put(HomeController());
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteColor,
      child: Column(
        children: [
          // ... appbar view
          Material(
            elevation: 3,
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: whiteColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  SafeArea(
                    child: Text(
                      "Inbox",
                      style: normalTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 26,
                      ),
                    ),
                  ),
                  TabBar(
                    indicatorColor: blueColor,
                    dividerColor: lightGreyColor,
                    enableFeedback: true,
                    controller: tabController,
                    labelColor: blueColor,
                    labelStyle: GoogleFonts.outfit(fontSize: 14),
                    unselectedLabelColor: darkGreyColor,
                    tabs: [
                      Tab(child: Text('Notifikasi')),
                      Tab(child: Text('Butuh Persetujuan')),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                NotificationPanel(controller: controller),
                (controller.u.manager == "1")
                    ? PersetujuanTabBar(controller: controller)
                    : NoAccessPanel(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NoAccessPanel extends StatelessWidget {
  const NoAccessPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Image.asset(
              "assets/icons/ic_noaccess.png",
              filterQuality: FilterQuality.high,
              fit: BoxFit.fill,
            ),
          ),
          const Gap(40),
          Text(
            "Need Access Requirements",
            textAlign: TextAlign.center,
            style: normalTextStyle.copyWith(
              fontSize: 18,
              color: redColor,
              fontWeight: semiBold,
            ),
          ),
        ],
      ),
    );
  }
}

class PersetujuanTabBar extends StatelessWidget {
  const PersetujuanTabBar({
    super.key,
    required this.controller,
  });

  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    Widget customTile(Function()? onTap, leading, title, trailing) => ListTile(
          onTap: onTap,
          leading: leading,
          title: Text(
            title,
            style: normalTextStyle.copyWith(
              fontWeight: regular,
            ),
          ),
          trailing: trailing,
        );

    return ListView(
      physics: ClampingScrollPhysics(),
      padding: const EdgeInsets.all(0),
      children: [
        customTile(
          () =>
              Get.toNamed(Routes.PERSETUJUAN_PAGE, arguments: "Reimbursement"),
          Icon(
            Icons.developer_board,
            color: HexColor("15B6A7"),
          ),
          "Reimbursement",
          Icon(
            Icons.navigate_next_outlined,
          ),
        ),
        customTile(
          () => Get.toNamed(Routes.PERSETUJUAN_PAGE, arguments: "Cuti"),
          Icon(
            Icons.access_time_filled_sharp,
            color: HexColor("3A84F3"),
          ),
          "Cuti",
          Icon(
            Icons.navigate_next_outlined,
          ),
        ),
        customTile(
          () => Get.toNamed(Routes.PERSETUJUAN_PAGE, arguments: "Absensi"),
          Icon(
            Icons.location_on_sharp,
            color: HexColor("F59E0C"),
          ),
          "Absensi",
          Icon(
            Icons.navigate_next_outlined,
          ),
        ),
        customTile(
          () => Get.toNamed(Routes.PERSETUJUAN_PAGE, arguments: "Lembur"),
          Icon(
            Icons.more_time_sharp,
            color: HexColor("FB7316"),
          ),
          "Lembur",
          Icon(
            Icons.navigate_next_outlined,
          ),
        ),
        customTile(
          () => Get.toNamed(Routes.PERSETUJUAN_PAGE,
              arguments: "Perubahan shift"),
          Icon(
            Icons.business_center_rounded,
            color: HexColor("EE4443"),
          ),
          "Perubahan shift",
          Icon(
            Icons.navigate_next_outlined,
          ),
        ),
        customTile(
          () =>
              Get.toNamed(Routes.PERSETUJUAN_PAGE, arguments: "Perubahan data"),
          Icon(
            Icons.account_box_sharp,
            color: HexColor("8B5DFB"),
          ),
          "Perubahan data",
          Icon(
            Icons.navigate_next_outlined,
          ),
        ),
        customTile(
          () => Get.toNamed(Routes.PERSETUJUAN_PAGE, arguments: "Formulir"),
          Icon(
            Icons.format_align_left_outlined,
            color: HexColor("8D5BF8"),
          ),
          "Formulir",
          Icon(
            Icons.navigate_next_outlined,
          ),
        ),
      ],
    );
  }
}

class NotificationPanel extends StatelessWidget {
  const NotificationPanel({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 0),
      children: List.generate(3, (index) {
        return ListTile(
          onTap: () => Get.to(
            DetailInboxView(),
            transition: Transition.cupertino,
          ),
          minVerticalPadding: 10,
          trailing: Icon(Iconsax.arrow_right_3),
          leading: CircleAvatar(
            backgroundColor: darkGreyColor,
          ),
          title: Text(
            "Maria Setiawati Purbanigtyas",
            style: normalTextStyle.copyWith(
              fontSize: 14,
              fontWeight: regular,
            ),
          ),
          subtitle: Text(
            "Your requested change data has been accepted",
            style: normalTextStyle.copyWith(
              fontWeight: regular,
              color: darkGreyColor,
              fontSize: 10,
            ),
          ),
        );
      }),
    );
  }
}
