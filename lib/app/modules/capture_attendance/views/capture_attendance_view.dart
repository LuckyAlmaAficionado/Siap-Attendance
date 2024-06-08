import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

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
  bool useFrontCamera = true;
  double currentExposureOffset = 0.0; // Current exposure offset
  double minExposureOffset = 0.0; // Minimum exposure offset
  double maxExposureOffset = 0.0; // Maximum exposure offset
  bool isTorchOn = false;

  @override
  void initState() {
    super.initState();
    // set status
    status = Get.arguments;
    CameraDescription cameraDescription;

    cameraDescription = c.cameras.firstWhere(
      (element) => element.lensDirection == CameraLensDirection.front,
      orElse: () => c.cameras.first,
    );

    c.camController = CameraController(
      cameraDescription,
      ResolutionPreset.veryHigh,
      enableAudio: false,
    );

    c.camController.initialize().then((_) async {
      await c.camController.initialize();

      // Get the exposure offset range
      minExposureOffset = await c.camController.getMinExposureOffset();
      maxExposureOffset = await c.camController.getMaxExposureOffset();

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

  Future<void> _toggleTorch() async {
    if (c.camController.value.flashMode == FlashMode.torch) {
      await c.camController.setFlashMode(FlashMode.off);
      setState(() {
        isTorchOn = false;
      });
    } else {
      await c.camController.setFlashMode(FlashMode.torch);
      setState(() {
        isTorchOn = true;
      });
    }
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

    if (!c.camController.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

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
                    Row(
                      children: [
                        const Icon(Boxicons.bx_brightness_half),
                        Expanded(
                          child: Slider(
                            value: currentExposureOffset,
                            min: minExposureOffset,
                            max: maxExposureOffset,
                            onChanged: (value) async {
                              setState(() {
                                currentExposureOffset = value;
                              });
                              print(value);
                              await c.camController.setExposureOffset(value);
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: _toggleTorch,
                          icon: isTorchOn
                              ? Icon(
                                  Icons.light_mode,
                                  color: Colors.amber.shade600,
                                )
                              : Icon(
                                  Icons.light_mode_outlined,
                                  color: Colors.black,
                                ),
                        ),
                      ],
                    ),
                    TextField1(
                      controller: c.noteC,
                      hintText: "Catatan",
                      obsecure: false,
                      preffixIcon: Icon(Boxicons.bx_note),
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
