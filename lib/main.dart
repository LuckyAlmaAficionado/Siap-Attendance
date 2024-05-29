import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:camera/camera.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:month_year_picker/month_year_picker.dart';

import 'package:talenta_app/app/controllers/model_controller.dart';
import 'package:talenta_app/app/modules/capture_attendance/controllers/capture_attendance_controller.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
  }

  await initializeDateFormatting("id_ID", null);
  await Get.put(ModelController(), permanent: true);
  Get.put(CaptureAttendanceController()).cameras(await availableCameras());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "SIAP",
      debugShowCheckedModeBanner: false,
      enableLog: false,
      theme: ThemeData(useMaterial3: false),
      initialRoute: Routes.AUTHENTICATION,
      getPages: AppPages.routes,
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
    );
  }
}
