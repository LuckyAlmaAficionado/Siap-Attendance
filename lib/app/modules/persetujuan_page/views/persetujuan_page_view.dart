import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:talenta_app/app/modules/persetujuan_page/views/detail_persetujuan_page_view.dart';
import 'package:talenta_app/app/shared/images/images.dart';
import 'package:talenta_app/app/shared/textfield/textfield_1.dart';
import 'package:talenta_app/app/shared/theme.dart';

import '../controllers/persetujuan_page_controller.dart';

class PersetujuanPageView extends GetView<PersetujuanPageController> {
  const PersetujuanPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: whiteColor,
        title: Obx(() => Text(
              controller.persetujuan.value,
              style: appBarTextStyle.copyWith(color: Colors.black),
            )),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: false,
        titleSpacing: 0,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: TextField1(
                hintText: "Cari...",
                preffixIcon: Icon(Boxicons.bx_search),
                fillColor: whiteColor,
              ),
            )),
      ),
      body: (true)
          ? ListView.builder(
              itemCount: 15,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(top: 1),
                  child: ListTile(
                    tileColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    onTap: () {
                      Get.to(
                        DetailPersetujuanPageView(),
                        transition: Transition.cupertino,
                      );
                    },
                    title: Text(
                      "Fachrun Wire Prana",
                      style: normalTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(2),
                        Text(
                          "Cuti Tahunan",
                          style: darkGreyTextStyle.copyWith(
                            fontWeight: extraLight,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "15 Apr 2024 - 3 days",
                          style: darkGreyTextStyle.copyWith(
                            fontWeight: extraLight,
                            fontSize: 12,
                          ),
                        ),
                        const Gap(5),
                      ],
                    ),
                    leading: ImageNetwork(url: "####"),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Pending",
                          style: normalTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: regular,
                          ),
                        ),
                        Text(
                          "12 hours ago",
                          style: darkGreyTextStyle.copyWith(
                            fontSize: 10,
                            fontWeight: extraLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'Tidak ada data tersedia',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
    );
  }
}
