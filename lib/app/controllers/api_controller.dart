import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:talenta_app/app/controllers/model_controller.dart';
import 'package:talenta_app/app/models/approval.dart';
import 'package:talenta_app/app/models/karyawan.dart';
import 'package:talenta_app/app/models/model_izin.dart';
import 'package:talenta_app/app/models/user_absensi.dart';
import 'package:talenta_app/app/models/users.dart';
import 'package:talenta_app/app/shared/detail_absen.dart';
import 'package:talenta_app/app/shared/error_alert.dart';

import '../modules/home/views/menu_view.dart';

class ApiController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // final BASE_URL = ""; // production
  final BASE_URL = "http://192.168.5.9:8080"; // dummy

  final Map<String, String> listApi = {
    "login": "api/v1/auth/login",
    "fetchAllEmployee": "api/v1/all-users",
    "todayAttendance": "api/v1/absensi",
    "permit": "api/izin/find",
    "addPermit": "api/izin",
    "detailAttendance": "api/v1/absensi/detail",
    "attendance": "api/v1/user-absensi",
    "fetchLatePermission": "api/v1/late",
    "approvalRequest": "api/approval-requests",
  };

  // === save model data

  final m = Get.find<ModelController>();

  // ===
  Future login(String email, String password) async {
    try {
      log("==== Start Login ====");

      Map<String, dynamic> body = {
        "email": "$email",
        "password": "$password",
      };

      print(body);

      Uri url = Uri.parse("${BASE_URL}/${listApi["login"]}");
      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      print(res.statusCode);

      if (res.statusCode == 200) {
        final result = json.decode(res.body);

        print(result);

        m.u(ModelLogin.fromJson(result).data);

        await fetchTodayAttendance();
        await fetchPermitByUserId();

        log("==== End Login ====");
        return true;
      }
      log("==== End Login Error ====");
      return false;
    } catch (e) {
      Get.dialog(ErrorAlert(
        msg: e.toString(),
        methodName: "login | api_controller.dart",
      ));
    }
  }

  Future fetchAllEmployee() async {
    log("==== fetchAll Employee ====");
    try {
      Uri url = Uri.parse("${BASE_URL}/${listApi["fetchAllEmployee"]}");
      final res = await http.get(url);
      print(res.statusCode);
      if (res.statusCode == 200) {
        final List result = json.decode(res.body);
        m.k(result.map((e) => Karyawan.fromJson(e)).toList());
        m.k.sort((a, b) => a.name!.compareTo(b.name!));

        log("==== End fetchAllEmployee ====");
      }
      log("==== End fetchAllEmployee Error ====");
    } catch (e) {
      Get.dialog(ErrorAlert(
          msg: e.toString(),
          methodName: "fetchAllEmployee | api_controller.dart"));
    }
  }

  // ===== Attendance

  Future fetchDetailAttendance() async {
    log("==== fetchDetailAttendance ====");

    try {
      Uri url = Uri.parse(
        "${BASE_URL}/${listApi["detailAttendance"]}/${m.u.value.user.id}",
      );

      final res = await http.get(
        url,
        headers: {"Authorization": "Bearer ${m.u.value.token}"},
      );

      if (res.statusCode == 200) {
        List result = json.decode(res.body);
        m.a(result.map((e) => ModelAbsensi.fromJson(e)).toList());

        log("==== End fetchDetailAttendance ====");
        return result.map((e) => ModelAbsensi.fromJson(e)).toList();
      }

      log("==== End fetchDetailAttendance Error ====");
      return null;
    } on HttpException catch (e) {
      Get.dialog(ErrorAlert(
        msg: e.toString(),
        methodName: "fetchDetailAttendance | api_controller.dart",
      ));
    }
  }

  Future fetchTodayAttendance() async {
    log("==== fetchTodayAttendance ====");

    try {
      Uri url = Uri.parse(
        "${BASE_URL}/${listApi["todayAttendance"]}/${m.u.value.user.id}",
      );
      final res = await http.post(url);

      if (res.statusCode == 200) {
        final List result = json.decode(res.body);
        List<ModelAbsensi> req =
            result.map((e) => ModelAbsensi.fromJson(e)).toList();
        m.ci(req.firstWhereOrNull((element) => element.type == "clockin"));
        m.co(req.firstWhereOrNull((element) => element.type == "clockout"));
      } else {
        m.ci(null);
        m.co(null);
      }
      log("==== End fetchTodayAttendance ====");
    } on HttpException catch (e) {
      Get.dialog(ErrorAlert(
        msg: e.toString(),
        methodName: "fetchTodayAttendance | api_controller.dart",
      ));
    }
  }

  Future submitAttendance(String note, File img) async {
    try {
      final url = Uri.parse("$BASE_URL/${listApi['attendance']}");

      var req = http.MultipartRequest("POST", url);

      req.files.add(await http.MultipartFile.fromPath(
        "image",
        img.path,
      ));

      req.headers.addAll({"Authorizaation": "Bearer ${m.u.value.token}"});

      // Get current location
      Position p = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        p.latitude,
        p.longitude,
      );

      Placemark pm = placemarks.first;

      String add =
          "${pm.street}, ${pm.locality}, ${pm.postalCode}, ${pm.country}";

      req.fields['user_absensi_id'] = m.u.value.user.id!;
      req.fields['lang'] = "${p.longitude}";
      req.fields['lat'] = "${p.latitude}";
      req.fields['address'] = add;
      req.fields['catatan'] = note.isEmpty ? "" : note;

      var res = await req.send();

      if (res.statusCode == 200) {
        await fetchTodayAttendance();
        await fetchPermitByUserId();

        Get.to(() => DetailAbsenView(status: true));
      }
      Get.to(() => DetailAbsenView(status: false));
    } on HttpException catch (e) {
      Get.dialog(ErrorAlert(
        msg: e.message,
        methodName: "attendance | api_controller.dart",
      ));
    }
  }

  // ===== Permit

  Future permitApplication(String note, File img) async {
    try {
      final url = Uri.parse("$BASE_URL/${listApi['addPermit']}");
      var req = http.MultipartRequest("POST", url);

      req.files.add(await http.MultipartFile.fromPath("image", img.path));

      Position p = await curLocations();

      req.fields['user_id'] = m.u.value.user.id!;
      req.fields['alasan'] = note.isEmpty ? "" : note;
      req.fields['latitude'] = "${p.latitude}";
      req.fields['longitude'] = "${p.longitude}";

      var res = await req.send();

      if (res.statusCode == 200) {
        Get.back();
        Get.off(() => MenuView(), transition: Transition.cupertino);
      }
    } catch (e) {
      Get.dialog(ErrorAlert(
        msg: e.toString(),
        methodName: "sendIzinToDatabase | camera_page_controller.dart",
      ));
    }
  }

  Future fetchPermitByUserId() async {
    log("==== fetchPermitByUserId ====");

    try {
      Uri url = Uri.parse("${BASE_URL}/${listApi['permit']}");

      final body = {"user_id": m.u.value.user.id};

      final res = await http.post(url, body: body);

      if (res.statusCode == 200) {
        final result = json.decode(res.body);
        List dt = result['data'];
        List<ModelIzin> mi = dt.map((e) => ModelIzin.fromJson(e)).toList();
        log("==== End fetchPermitByUserId ====");
        return mi;
      }

      log("==== fetchPermitByUserId Error ====");

      return null;
    } on HttpException catch (e) {
      Get.dialog(ErrorAlert(
          msg: e.toString(),
          methodName: "fetchTodayAttendance | api_controller.dart"));
    }
  }

  // ===== Utils

  calculateLateMinutes() async {
    // Mendapatkan waktu istirahat (12:45) dalam bentuk TimeOfDay
    final TimeOfDay restTime = TimeOfDay(hour: 12, minute: 45);

    final TimeOfDay lateTime = TimeOfDay.fromDateTime(DateTime.now());

    // Menghitung selisih waktu dalam menit
    int lateMinutes = lateTime.hour * 60 +
        lateTime.minute -
        (restTime.hour * 60 + restTime.minute);

    // Jika terlambat, pastikan nilai menit tidak kurang dari 0
    if (lateMinutes < 0) {
      lateMinutes = 0;
    }

    return lateMinutes;
  }

  Future curLocations() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  // ==== Izin Terlambat

  Future fetchLatePermission(String note) async {
    log("==== fetchLatePermission ====");

    try {
      Uri url = Uri.parse("${BASE_URL}/${listApi['fetchLatePermission']}");
      int r = calculateLateMinutes();

      Position p = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      final body = {
        "user_id": m.u.value.user.id,
        "alasan": note,
        "late_minutes": r,
        "latitude": p.latitude.toString(),
        "longitude": p.longitude.toString(),
      };

      var res = await http.post(url, body: body);

      if (res.statusCode == 200) {}
    } on HttpException catch (e) {
      Get.dialog(ErrorAlert(
          msg: e.toString(),
          methodName: "fetchIzinTerlambat | api_controller.dart"));
    }
  }

  // ==== Approval Izin

  Future fetchApprovalByUserId() async {
    try {
      Uri url = Uri.parse(
        "${BASE_URL}/${listApi['approvalRequest']}/${m.u.value.user.id}/id",
      );

      var req = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (req.statusCode == 200) {
        List js = json.decode(req.body);
        List<Approval> listApp = js.map((e) => Approval.fromJson(e)).toList();
        return listApp;
      }
      return null;
    } on HttpException catch (e) {
      Get.dialog(ErrorAlert(
        msg: e.toString(),
        methodName: "fetchApprovalRequest | api_controller.dart",
      ));
    }
  }

  Future approvalPermit() async {
    log("==== approvalPermit ====");
    try {
      Uri url = Uri.parse(
        "${BASE_URL}/${listApi['fetchApprovalRequest']}/ece7d79d-fd4f-4c37-b44e-9f03a77141a5/approve",
      );

      var res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({"approver": "user1@example.com"}),
      );

      if (res.statusCode == 200) {
        return true;
      }
      return false;
    } on HttpException catch (e) {
      Get.dialog(ErrorAlert(
          msg: e.toString(),
          methodName: "approvalPermit | api_controller.dart"));
    }
  }

  Future approvalRequest(String desc) async {
    try {
      Map<String, dynamic> body = {
        "description": desc,
        "userId": "${m.u.value.user.id}",
        "approvers": [
          "user1@example.com",
          "user2@example.com",
          "user3@example.com"
        ]
      };

      var res = await http.post(
          Uri.parse("$BASE_URL/${listApi['approvalRequest']}"),
          body: json.encode(body),
          headers: {"Content-Type": "application/json"});

      if (res.statusCode == 200) {
        Get.snackbar("success", "success to send approval request");
        Get.off(() => MenuView(), transition: Transition.cupertino);
      }
      Get.snackbar("failed", "failed to send approval request");
    } on HttpException catch (e) {
      Get.dialog(ErrorAlert(
        msg: e.toString(),
        methodName: "approvalRequest | api_controller.dart",
      ));
    }
  }

  Future findApprovalById(String approvalId) async {
    try {
      Uri url = Uri.parse(
        "${BASE_URL}/${listApi['approvalRequest']}/$approvalId",
      );

      final req = await http.get(url);

      if (req.statusCode == 200) {
        var js = json.decode(req.body);
        Approval app = Approval.fromJson(js);
        return app;
      }
      return null;
    } on HttpException catch (e) {
      Get.dialog(ErrorAlert(
        msg: e.toString(),
        methodName: "findApprovalByIdApproval | api_controller.dart",
      ));
    }
  }
}
