import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talenta_app/app/modules/capture_attendance/controllers/capture_attendance_controller.dart';

class ImageNetwork extends StatelessWidget {
  const ImageNetwork({
    super.key,
    required this.url,
    this.borderRadius = 100,
    this.boxFit = BoxFit.fill,
  });

  final String url;
  final double? borderRadius;
  final BoxFit? boxFit;
  @override
  Widget build(BuildContext context) {
    final images = Get.put(CaptureAttendanceController());

    return FutureBuilder(
      future: images.loadImage(url),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            child: Icon(
              Icons.person_2_rounded,
              color: Colors.grey.shade500,
            ),
          );
        }
        if (snapshot.hasData) {
          print(snapshot.data);
          return ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius!),
            child: Image.file(
              snapshot.data,
              fit: boxFit,
              errorBuilder: (context, error, stackTrace) => CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                child: Icon(
                  Icons.person_2_rounded,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
          );
        }
        return (url.isEmpty)
            ? CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                child: Icon(
                  Icons.person_2_rounded,
                  color: Colors.grey.shade500,
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius!),
                child: Image.network(
                  url,
                  fit: boxFit,
                  loadingBuilder: (context, child, loadingProgress) =>
                      loadingProgress != null
                          ? Container(
                              color: Colors.grey.shade300,
                              padding: const EdgeInsets.all(13.0),
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  strokeCap: StrokeCap.round,
                                ),
                              ),
                            )
                          : child,
                  errorBuilder: (context, error, stackTrace) => CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(
                      Icons.person_2_rounded,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
              );
      },
    );
  }
}
