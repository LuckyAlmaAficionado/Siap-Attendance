import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:talenta_app/app/shared/button/button_1.dart';
import 'package:talenta_app/app/shared/textfield/textfield_1.dart';
import 'package:talenta_app/app/shared/theme.dart';
import 'package:talenta_app/app/shared/utils.dart';

import '../controllers/camera_page_controller.dart';

class CameraPageView extends GetView<CameraPageController> {
  @override
  Widget build(BuildContext context) {
    controller.status = Get.arguments ?? "";
    return Scaffold(
      body: Container(
        height: context.height,
        width: context.width,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: FutureBuilder<void>(
                future: controller.initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(controller.cameraC);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 180,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 30,
                ),
                color: whiteColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField1(
                      controller: controller.note,
                      hintText: "Jika izin wajib di input",
                      preffixIcon: Icon(Iconsax.note_1),
                    ),
                    const Spacer(),
                    Button1(
                      title: 'Lampirkan ${controller.status}',
                      onTap: () async {
                        if (controller.status == "argument-izin") {
                          // cek apakah note sudah diisi

                          if (controller.note.text.isEmpty) {
                            Utils().informationUtils(
                              "Peringatan !",
                              "alasan wajib di isi untuk pengajuan izin",
                              true,
                            );
                            return;
                          } else {
                            Utils().informationUtils(
                              "Loading...!",
                              "tunggu sebentar",
                              false,
                            );
                            await controller.onPressButton();
                          }
                        } else {
                          Utils().informationUtils(
                            "Loading...!",
                            "tunggu sebentar",
                            false,
                          );
                          await controller.onPressButton();
                        }

                        controller.note.text = ""; // set default null
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
