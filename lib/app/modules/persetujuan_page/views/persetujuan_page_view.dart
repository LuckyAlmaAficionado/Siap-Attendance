import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:talenta_app/app/modules/persetujuan_page/views/detail_persetujuan_page_view.dart';
import 'package:talenta_app/app/shared/theme.dart';

import '../controllers/persetujuan_page_controller.dart';

class PersetujuanPageView extends GetView<PersetujuanPageController> {
  const PersetujuanPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
              controller.persetujuan.value,
              style: appBarTextStyle,
            )),
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black12.withOpacity(0.1),
                      prefixIcon: Icon(
                        Icons.search,
                        color: lightGreyColor,
                      ),
                      hintText: "Cari...",
                      hintStyle: lightGreyTextStyle,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const Gap(20),
                ],
              ),
            )),
      ),
      body: (true)
          ? ListView.builder(
              itemCount: 15,
              padding: const EdgeInsets.only(top: 10),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
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
                          const Gap(5),
                          Text(
                            "Cuti Tahunan",
                            style: darkGreyTextStyle.copyWith(
                              fontWeight: extraLight,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "15 Apr - 17 Apr 2024 - 3 days",
                            style: darkGreyTextStyle.copyWith(
                              fontWeight: extraLight,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      leading: CircleAvatar(),
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
                    Divider(
                      thickness: 1,
                      color: lightGreyColor,
                    ),
                  ],
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
