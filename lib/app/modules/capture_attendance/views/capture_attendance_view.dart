import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:talenta_app/app/modules/capture_attendance/controllers/capture_attendance_controller.dart';
import 'package:talenta_app/app/shared/button/button_1.dart';
import 'package:talenta_app/app/shared/textfield/textfield_1.dart';
import 'package:talenta_app/app/shared/theme.dart';

class CaptureAttendanceView extends StatefulWidget {
  const CaptureAttendanceView({Key? key}) : super(key: key);

  @override
  State<CaptureAttendanceView> createState() => _CaptureAttendanceViewState();
}

class _CaptureAttendanceViewState extends State<CaptureAttendanceView> {
  final c = Get.put(CaptureAttendanceController());
  String status = '';

  @override
  void initState() {
    super.initState();
    // set status
    status = Get.arguments;

    c.cameras.firstWhere(
      (element) => element.lensDirection == CameraLensDirection.front,
      orElse: () => c.cameras.first,
    );

    c.camController = CameraController(
      c.cameras[0],
      ResolutionPreset.ultraHigh,
    );

    c.camController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    c.camController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: CameraPreview(c.camController)),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: whiteColor,
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Container(
                      width: width * 0.2,
                      height: height * 0.005,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey.shade400,
                      ),
                    ),
                    TextField1(
                      controller: c.noteC,
                      hintText: "Catatan",
                      obsecure: false,
                      preffixIcon: Icon(Iconsax.note),
                    ),
                    const Gap(10),
                    Button1(
                      title: "Submit Attendance",
                      onTap: () async => c.onSubmitButton(status),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
