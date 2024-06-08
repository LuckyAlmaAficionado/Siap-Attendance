import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:talenta_app/app/modules/reimbursement_page/views/pengajuan_reimbursement_page_view.dart';
import 'package:talenta_app/app/modules/reimbursement_page/views/pengajuan_reimbursement_textfield_view.dart';
import 'package:talenta_app/app/modules/reimbursement_page/views/persetujuan_reimbursement_page_view.dart';
import 'package:talenta_app/app/shared/utils.dart';

import '../../../shared/theme.dart';
import '../controllers/reimbursement_page_controller.dart';

class ReimbursementPageView extends GetView<ReimbursementPageController> {
  const ReimbursementPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reimbursement',
          style: appBarTextStyle.copyWith(
            fontWeight: regular,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Material(
            elevation: 3,
            child: Container(
              width: Get.width,
              height: 230,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: Get.height * 0.1,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: darkGreyColor),
                    ),
                    child: (false)
                        ? SizedBox()
                        : Center(
                            child: Text(
                              "Anda tidak memiliki saldo reimbursement",
                              style: blackTextStyle.copyWith(
                                fontWeight: regular,
                                fontSize: 14,
                              ),
                            ),
                          ),
                  ),
                  const Gap(15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomButton(
                      title: 'Ajukan Reimbursement',
                      onTap: () => Get.to(
                        PengajuanReimbursementTextfieldView(),
                        transition: Transition.cupertino,
                      ),
                    ),
                  ),
                  const Gap(15),
                  TabBar(
                    controller: controller.controller,
                    tabs: [
                      Tab(
                        child: Text(
                          "Pengajuan",
                          style: blackTextStyle.copyWith(
                            fontWeight: regular,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Disetujui",
                          style: blackTextStyle.copyWith(
                            fontWeight: regular,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: TabBarView(
              controller: controller.controller,
              children: [
                PengajuanReimbursementPageView(),
                PersetujuanReimbursementPageView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
