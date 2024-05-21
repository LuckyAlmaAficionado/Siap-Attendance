import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
          title: Text(
            'Terlambat Masuk',
            style: appBarTextStyle,
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
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

                        return ListTile(
                          onTap: () async {
                            controller.a
                                .findApprovalById(model.id)
                                .then((value) => Get.to(
                                      () => DetailTelatMasukView(),
                                      arguments: value,
                                      transition: Transition.cupertino,
                                    ));
                          },
                          title: Text(
                            "Pengajuan Izin Telat",
                            style: normalTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: medium,
                              color: blackColor,
                            ),
                          ),
                          subtitle: Text(
                            "${DateFormat("dd MMM yyyy", "id_ID").format(DateTime.now())}",
                            style: normalTextStyle.copyWith(
                              color: darkGreyColor,
                              fontSize: 12,
                            ),
                          ),
                          trailing: SizedBox(
                            child: Text(
                              "",
                              style: normalTextStyle.copyWith(
                                fontSize: 12,
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
