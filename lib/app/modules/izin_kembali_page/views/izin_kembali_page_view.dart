import 'dart:io';

import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:talenta_app/app/shared/theme.dart';
import 'package:talenta_app/app/shared/utils.dart';

import '../controllers/izin_kembali_page_controller.dart';

class IzinKembaliPageView extends GetView<IzinKembaliPageController> {
  const IzinKembaliPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Form Izin",
          style: appBarTextStyle,
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const Gap(20),
            Text(
              "Alasan izin kembali",
              style: blackTextStyle.copyWith(
                fontWeight: regular,
                fontSize: 14,
              ),
            ),
            const Gap(7),
            SizedBox(
              width: Get.width,
              child: TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  hintText: "Ada keperluan yang tidak dapat di tinggalkan",
                  hintStyle: darkGreyTextStyle.copyWith(
                    fontWeight: regular,
                    fontSize: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 1,
                      color: darkBlueColor,
                    ),
                  ),
                ),
              ),
            ),
            const Gap(20),
            Text(
              "Foto Bukti",
              style: blackTextStyle.copyWith(
                fontWeight: regular,
                fontSize: 14,
              ),
            ),
            const Gap(7),
            GestureDetector(
              onTap: () async {
                await Get.bottomSheet(
                  Container(
                    width: Get.width,
                    height: 100,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async => controller.pathImg.value =
                              (await controller.cameraC
                                      .pickImage(ImageSource.gallery))
                                  .path,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.image_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Galeri",
                                style: blackTextStyle,
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () async => controller.pathImg.value =
                              (await controller.cameraC
                                      .pickImage(ImageSource.camera))
                                  .path,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Kamera",
                                style: blackTextStyle,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                width: Get.width,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    width: 1,
                    color: darkGreyColor,
                  ),
                ),
                child: Obx(() => (controller.pathImg.isEmpty)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt_outlined,
                            color: darkGreyColor,
                            size: 100,
                          ),
                          Text(
                            "Ambil Gambar",
                            style: darkGreyTextStyle.copyWith(
                              fontWeight: semiBold,
                              fontSize: 16,
                            ),
                          )
                        ],
                      )
                    : Image.file(File(controller.pathImg.value))),
              ),
            ),
            const Gap(25),
            CustomButton(
              title: 'Kirim',
              onTap: () async {
                Utils().informationUtils(
                  'Loading...!',
                  "Tunggu sebentar yaa...!",
                  false,
                );

                await controller.onButtonPressed();

                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
