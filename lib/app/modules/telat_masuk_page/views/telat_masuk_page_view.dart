import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:talenta_app/app/shared/theme.dart';
import 'package:talenta_app/app/shared/utils.dart';

import '../controllers/telat_masuk_page_controller.dart';

class TelatMasukPageView extends GetView<TelatMasukPageController> {
  TelatMasukPageView({Key? key}) : super(key: key);

  final controller = Get.put(TelatMasukPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Pengajuan Telat Masuk',
            style: appBarTextStyle,
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const Gap(20),
                ListTile(
                  title: RichText(
                    text: TextSpan(
                      text: "Alasan Keterlambatan ",
                      style: blackTextStyle.copyWith(
                        fontWeight: medium,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: "*Wajib diisi",
                          style: redTextStyle.copyWith(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(0),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: TextField(
                      minLines: 5,
                      maxLines: 6,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        hintText: "Alasan keterlambatan",
                        hintStyle: darkGreyTextStyle.copyWith(
                          fontWeight: regular,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(15),
              ],
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: CustomButton(
                title: 'Ajukan Telat Masuk',
                onTap: () async {
                  Utils().informationUtils(
                    "Loading...!",
                    "Tunggu sebentar yaa...!",
                    false,
                  );

                  await controller.onPressedAction();

                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ));
  }
}
