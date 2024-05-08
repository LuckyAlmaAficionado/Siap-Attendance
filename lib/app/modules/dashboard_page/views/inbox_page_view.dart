import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:talenta_app/app/modules/dashboard_page/controllers/dashboard_page_controller.dart';
import 'package:talenta_app/app/modules/dashboard_page/views/detail_inbox_view.dart';
import 'package:talenta_app/app/routes/app_pages.dart';
import 'package:talenta_app/app/shared/theme.dart';

class InboxPageView extends StatefulWidget {
  const InboxPageView({super.key});

  @override
  State<InboxPageView> createState() => _InboxPageViewState();
}

class _InboxPageViewState extends State<InboxPageView>
    with TickerProviderStateMixin {
  final dashC = Get.put(DashboardPageController());
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
          Container(
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
                    "Informasi",
                    style: blackTextStyle.copyWith(
                      fontWeight: bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TabBar(
                  indicatorColor: blueColor,
                  dividerColor: lightGreyColor,
                  enableFeedback: true,
                  controller: tabController,
                  labelColor: blueColor,
                  labelStyle: GoogleFonts.outfit(fontSize: 15),
                  unselectedLabelColor: darkGreyColor,
                  tabs: [
                    Tab(
                      child: Text(
                        'Notifikasi',
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Butuh Persetujuan',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                NotificationTabBar(dashC: dashC),
                (dashC.authC.data.value!.data.user.manager == "1")
                    ? PersetujuanTabBar(dashC: dashC)
                    : SizedBox(
                        width: Get.width,
                        height: Get.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 300,
                              height: 300,
                              child: Image.asset(
                                "assets/images/img_onboarding1.png",
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const Gap(40),
                            Text(
                              "Anda tidak memiliki\nakses untuk ini",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: medium,
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
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
    required this.dashC,
  });

  final DashboardPageController dashC;
  @override
  Widget build(BuildContext context) {
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
}

class NotificationTabBar extends StatelessWidget {
  const NotificationTabBar({
    super.key,
    required this.dashC,
  });

  final DashboardPageController dashC;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 0),
      children: List.generate(3, (index) {
        return ListTile(
          onTap: () => Get.to(
            DetailInboxView(),
            transition: Transition.downToUp,
          ),
          minVerticalPadding: 10,
          trailing: Icon(Icons.navigate_next_sharp),
          leading: CircleAvatar(
            backgroundColor: darkGreyColor,
          ),
          title: Text(
            "Maria Setiawati Purbanigtyas",
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: regular,
            ),
          ),
          subtitle: Text(
            "Your requested change data has been accepted",
            style: darkGreyTextStyle.copyWith(
              fontWeight: extraLight,
              fontSize: 12,
            ),
          ),
        );
      }),
    );
  }
}
