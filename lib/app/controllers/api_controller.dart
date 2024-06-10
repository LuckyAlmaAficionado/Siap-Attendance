import 'dart:async';
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
import 'package:talenta_app/app/models/locations.dart';
import 'package:talenta_app/app/models/model_izin.dart';
import 'package:talenta_app/app/models/user_absensi.dart';
import 'package:talenta_app/app/models/user_job.dart';
import 'package:talenta_app/app/models/user_schedule_setting_model.dart';
import 'package:talenta_app/app/models/user_shift_setting_model.dart';
import 'package:talenta_app/app/models/users.dart';
import 'package:talenta_app/app/modules/authentication/views/login_view.dart';
import 'package:talenta_app/app/shared/button/button_1.dart';
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

  // production
  // final BASE_URL = "https://andioffset-siap-production.up.railway.app";

  // dummy
  final BASE_URL = "http://192.168.5.9:8000";
  // final BASE_URL = "http://192.168.71.195:8000";

  final Map<String, String> listApi = {
    "login": "api/v1/auth/login", //
    "fetchAllEmployee": "api/v1/all-users", // done
    "todayAttendance": "api/v1/absensi", // done
    "permit": "api/izin/find", // not fix yet
    "addPermit": "api/izin", // not fix yet
    "detailAttendance": "api/v1/absensi/detail", // done
    "attendance": "api/v1/attendance", // done
    "fetchLatePermission": "api/v1/late",
    "approvalRequest": "api/approval-requests",
    "userJob": "api/v1/user-job",
  };

  // ==== detail information job
  Future fetchUserJob() async {
    m.job.value = UserJobModel();
    try {
      Uri url = Uri.parse("$BASE_URL/${listApi["userJob"]}/${m.u.value!.id}");
      print(url);
      final req = await http.get(url);

      if (req.statusCode == 200) {
        final result = json.decode(req.body);
        UserJobModel userJob = UserJobModel.fromJson(result);
        m.job(userJob);

        // set approval
        approvalSetId(
          userJob.approvalAbsensi!,
          userJob.approvalIstirahatTelat!,
          userJob.approvalIzinKembali!,
          userJob.approvalLembur!,
          userJob.approvalShift!,
        );

        return userJob;
      }
    } on HttpException catch (e) {
      Get.dialog(ErrorAlert(
        msg: e.message,
        methodName: "fetchUserJob | api_controller.dart",
      ));
    }
  }

  approvalSetId(String absensi, String istirahatTelat, String izinKembali,
      String lembur, String shifts) {
    m.apprAbsensi = absensi;
    m.apprIstirahatTelat = istirahatTelat;
    m.apprIzinKembali = izinKembali;
    m.apprLembur = lembur;
    m.apprShift = shifts;
  }

  // === save model data

  final m = Get.find<ModelController>();

  // ===== Locations
  Future getLocations() async {
    log("=== getLocations ===");
    try {
      print(m.u.value!.id);
      Uri url = Uri.parse("$BASE_URL/api/v1/locations/${m.u.value!.id}/id");
      final res = await http.get(url);

      print(res.statusCode);

      if (res.statusCode == 200) {
        final result = json.decode(res.body);
        print(result);
        List temp = result['data'];
        List data = temp.map((e) => e['attendance']).toList();
        return data.map((e) => ModelLocations.fromJson(e)).toList();
      }
    } on HttpException catch (e) {
      Get.dialog(ErrorAlert(
        msg: e.message,
        methodName: "getLocations | api_controller.dart",
      ));
    }
  }

  // ===
  Future login(String email, String password) async {
    m.u.value = ModelUser();

    try {
      log("==== Start Login ====");

      Map<String, dynamic> body = {
        "email": "$email",
        "password": "$password",
      };

      Uri url = Uri.parse("${BASE_URL}/${listApi["login"]}");
      final res = await http
          .post(
            url,
            headers: {"Content-Type": "application/json"},
            body: json.encode(body),
          )
          .timeout(
            const Duration(seconds: 3),
            onTimeout: () async => await Get.dialog(AlertDialog(
              content: Container(
                child: Column(
                  children: [
                    Text("Timeout"),
                    Button1(
                      title: "Coba Lagi",
                      onTap: () => Get.to(() => LoginView(),
                          transition: Transition.cupertino),
                    ),
                  ],
                ),
              ),
            )),
          );

      if (res.statusCode == 200) {
        final result = json.decode(res.body);
        m.u(ModelUser.fromJson(result['data']));
        m.userId = m.u.value!.id.toString();
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
        return;
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
        "${BASE_URL}/${listApi["detailAttendance"]}/${m.u.value!.id}",
      );

      final res = await http.get(
        url,
        // headers: {"Authorization": "Bearer ${m.u.value!.token}"},
      );

      if (res.statusCode == 200) {
        List result = json.decode(res.body);
        print(result.map((e) => ModelAbsensi.fromJson(e)).toList());
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
      m.ci(null);
      m.co(null);

      Uri url = Uri.parse("${BASE_URL}/${listApi["attendance"]}/details");
      log(DateTime.now().toString());
      final res = await http.post(
        url,
        body: {
          "users_id": m.u.value!.id,
          "time": DateTime.now().toString(),
        },
      );

      log("status: ${res.statusCode}");
      log("status: ${res.body}");
      if (res.statusCode == 200) {
        final List result = json.decode(res.body);
        List<ModelAbsensi> req =
            result.map((e) => ModelAbsensi.fromJson(e)).toList();
        req.forEach((element) => element.type);
        m.ci(req.firstWhereOrNull((element) => element.type == "Clock-In"));
        m.co(req.firstWhereOrNull((element) => element.type == "Clock-Out"));
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

  Future submitAttendance(String note, File img, String status) async {
    log("--- submit attendance ---");

    try {
      final url = Uri.parse("$BASE_URL/${listApi['attendance']}");

      var req = http.MultipartRequest("POST", url);

      req.files.add(await http.MultipartFile.fromPath(
        "images",
        img.path,
      ));

      req.headers.addAll({"Authorizaation": "Bearer ${m.u.value!.token}"});

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

      req.fields['user_absensi_id'] = m.u.value!.id!;
      req.fields['lang'] = "${p.longitude}";
      req.fields['lat'] = "${p.latitude}";
      req.fields['address'] = add;
      req.fields['catatan'] = note.isEmpty ? "" : note;
      req.fields["localDate"] = DateTime.now().toString();

      var res = await req.send();

      if (res.statusCode == 200) {
        await fetchTodayAttendance();
        await fetchPermitByUserId();

        Get.to(
          () => DetailAbsenView(
            status: true,
            stat: status,
          ),
        );
      }
      Get.to(
        () => DetailAbsenView(
          status: false,
          stat: "",
        ),
      );
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

      req.fields['user_id'] = m.u.value!.id!;
      req.fields['alasan'] = note.isEmpty ? "" : note;
      req.fields['latitude'] = "${p.latitude}";
      req.fields['longitude'] = "${p.longitude}";

      var res = await req.send();

      if (res.statusCode == 200) {
        Get.back();
        fetchPermitByUserId().then((value) => Get.offAll(
              () => MenuView(),
              transition: Transition.cupertino,
            ));
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

      final body = {"user_id": m.u.value!.id};

      final res = await http.post(url, body: body);

      if (res.statusCode == 200) {
        final result = json.decode(res.body);
        if (result['data'] == null) {
          return null;
        }

        List dt = result['data'];
        List<ModelIzin> mi = dt.map((e) => ModelIzin.fromJson(e)).toList();
        log("==== End fetchPermitByUserId ====");
        return mi;
      }

      log("==== fetchPermitByUserId Error ====");

      return null;
    } on HttpException catch (e) {
      Get.dialog(ErrorAlert(
          msg: e.message,
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
        "user_id": m.u.value!.id,
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
        "${BASE_URL}/${listApi['approvalRequest']}/${m.u.value!.id}/id",
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
        "description": "Mengurus kartu XL yang ribet",
        "userId": "${m.u.value!.id}",
        "approvers": ["manager", "personalia"]
      };

      var res = await http.post(
          Uri.parse("$BASE_URL/${listApi['approvalRequest']}"),
          body: json.encode(body),
          headers: {"Content-Type": "application/json"});

      if (res.statusCode == 200) {
        Get.snackbar("success", "success to send approval request");
        Get.offAll(() => MenuView(), transition: Transition.cupertino);
        return;
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

  // ======== fetch shifts

  Future fetchSchedule() async {
    try {
      Uri url = Uri.parse("${BASE_URL}/api/v1/schedule/${m.userId}/id");
      final req = await http.get(url);

      if (req.statusCode == 200) {
        var js = json.decode(req.body);
        m.startDate = js["startDate"];
        UserScheduleSettingModel s =
            UserScheduleSettingModel.fromJson(js["schedule"]);
        m.scheduleId = s.id!;
      }
    } on HttpException catch (e) {
      Get.dialog(ErrorAlert(
        msg: e.message,
        methodName: "fetchShifts | api_controller.dart",
      ));
    }
  }

  Future fetchShifts() async {
    await fetchSchedule();
    log("=== fetchShifts ===");

    try {
      Uri url = Uri.parse("${BASE_URL}/api/v1/shifts-assign");
      final req = await http.post(url, body: {
        "schedule_id": "${m.scheduleId}",
      });
      print(m.startDate);
      if (req.statusCode == 200) {
        List<dynamic> dynamicList = json.decode(req.body)["data"];
        List<UserShiftSettingModel> models = dynamicList
            .map((e) => UserShiftSettingModel.fromJson(e["userShift"]))
            .toList();

        return models;
      }
    } on HttpException catch (e) {
      Get.dialog(ErrorAlert(
        msg: e.message,
        methodName: "fetchShifts | api_controller.dart",
      ));
    }
  }

  Future logOut() async {
    await Get.delete<ModelController>();
    Get.offAll(() => LoginView());
  }
}
