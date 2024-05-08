import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:get/get.dart';

import 'package:talenta_app/app/shared/utils.dart';

import '../controllers/camera_page_controller.dart';

class CameraPageView extends GetView<CameraPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
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
          Container(
            height: 100,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  title: "Kirim Absensi",
                  onTap: () async {
                    Utils().informationUtils(
                        "Loading...!", "tunggu sebentar", false);
                    await controller.onPressButton();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
