import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';

import 'package:talenta_app/app/models/approval.dart';
import 'package:talenta_app/app/modules/telat_masuk_page/views/detail_telat_masuk_view.dart';
import 'package:talenta_app/app/shared/button/button_1.dart';
import 'package:talenta_app/app/shared/theme.dart';

import '../controllers/telat_masuk_page_controller.dart';

class TelatMasukPageView extends GetView<TelatMasukPageController> {
  TelatMasukPageView({Key? key}) : super(key: key);

  final controller = Get.put(TelatMasukPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Istirahat Telat',
            style: appBarTextStyle.copyWith(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: Get.width,
              height: Get.height,
              child: FutureBuilder(
                future: controller.a.fetchApprovalByUserId(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    List<Approval> listApp = snapshot.data;
                    print("listApp lenght: ${listApp.length}");

                    return ListView.builder(
                      itemCount: listApp.length,
                      itemBuilder: (context, index) {
                        Approval model = listApp[index];

                        return Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Material(
                            elevation: 1,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              onTap: () async {
                                controller.a.findApprovalById(model.id).then(
                                      (value) => Get.to(
                                        () => DetailTelatMasukView(),
                                        transition: Transition.cupertino,
                                        arguments: value,
                                      ),
                                    );
                              },
                              borderRadius: BorderRadius.circular(15),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    HeroIcon(
                                      HeroIcons.documentText,
                                      size: 30,
                                      color: Colors.pink,
                                    ),
                                    // Icon(
                                    //   Iconsax.task_square,
                                    //   size: 30,
                                    //   color: Colors.pink,
                                    // ),
                                    const Gap(15),
                                    SizedBox(
                                      width: context.width * 0.4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${DateFormat("dd MMM yyyy", "id_ID").format(DateTime.now())} - ${DateFormat("HH:mm", "id_ID").format(DateTime.now())} WIB",
                                            style: normalTextStyle.copyWith(
                                              fontSize: 10,
                                              color: Colors.black45,
                                            ),
                                          ),
                                          Text(
                                            "Status Izin",
                                            style: normalTextStyle.copyWith(
                                              fontSize: 14,
                                              fontWeight: medium,
                                            ),
                                          ),
                                          Text(
                                            "Catatan: Sedang ada acara keluarga sebentar yang harus dilaksanakan",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: normalTextStyle.copyWith(
                                              fontSize: 10,
                                              color: Colors.black45,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      color: Colors.pink,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Button1(
                title: "Pengajuan Terlambat",
                onTap: () async {
                  await controller.submitAction();
                },
              ),
            ),
          ],
        ));
  }
}
