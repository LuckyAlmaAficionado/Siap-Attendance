import 'dart:convert';
import 'dart:developer' as d;
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:talenta_app/app/controllers/model_controller.dart';
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
    "detailAttendance": "api/v1/absensi/detail"
  };

  // === save model data

  final m = Get.find<ModelController>();
  final dio = Dio();

  // ===
  Future login(String email, String password) async {
    try {
      d.log("==== Start Login ====");

      Map<String, dynamic> body = {
        "email": "$email",
        "password": "$password",
      };

      final res = await dio.post("${BASE_URL}/${listApi["login"]}", data: body);

      if (res.statusCode == 200) {
        final result = res.data;
        m.u(ModelLogin.fromJson(result).data);

        await fetchTodayAttendance();
        await fetchPermitByUserId();

        d.log("==== End Login ====");
        return true;
      }
      d.log("==== End Login Error ====");
      return false;
    } catch (e) {
      Get.dialog(ErrorAlert(
        msg: e.toString(),
        methodName: "fetchUser | api_controller.dart",
      ));
    }
  }

  Future fetchAllEmployee() async {
    d.log("==== fetchAll Employee ====");
    try {
      Uri url = Uri.parse("${BASE_URL}/${listApi["fetchAllEmployee"]}");
      final res = await http.get(url);
      print(res.statusCode);
      if (res.statusCode == 200) {
        final List result = json.decode(res.body);
        m.k(result.map((e) => Karyawan.fromJson(e)).toList());
        m.k.sort((a, b) => a.name!.compareTo(b.name!));

        d.log("==== End fetchAllEmployee ====");
      }
      d.log("==== End fetchAllEmployee Error ====");
    } catch (e) {
      Get.dialog(ErrorAlert(
          msg: e.toString(),
          methodName: "fetchAllEmployee | api_controller.dart"));
    }
  }

  // ===== Attendance

  Future fetchDetailAttendance() async {
    d.log("==== fetchDetailAttendance ====");

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

        d.log("==== End fetchDetailAttendance ====");
        return result.map((e) => ModelAbsensi.fromJson(e)).toList();
      }

      d.log("==== End fetchDetailAttendance Error ====");
      return null;
    } on HttpException catch (e) {
      Get.dialog(ErrorAlert(
        msg: e.toString(),
        methodName: "fetchDetailAttendance | api_controller.dart",
      ));
    }
  }

  Future fetchTodayAttendance() async {
    d.log("==== fetchTodayAttendance ====");

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
      d.log("==== End fetchTodayAttendance ====");
    } on HttpException catch (e) {
      Get.dialog(ErrorAlert(
        msg: e.toString(),
        methodName: "fetchTodayAttendance | api_controller.dart",
      ));
    }
  }

  Future attendance(String note, File img) async {
    try {
      final url = Uri.parse("uri");

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
      final url = Uri.parse("$BASE_URL/api/izin");
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
    d.log("==== fetchPermitByUserId ====");

    try {
      Uri url = Uri.parse("${BASE_URL}/${listApi['permit']}");

      final body = {"user_id": m.u.value.user.id};

      final res = await http.post(url, body: body);

      if (res.statusCode == 200) {
        final result = json.decode(res.body);
        List dt = result['data'];
        List<ModelIzin> mi = dt.map((e) => ModelIzin.fromJson(e)).toList();
        d.log("==== End fetchPermitByUserId ====");
        return mi;
      }

      d.log("==== fetchPermitByUserId Error ====");

      return null;
    } on HttpException catch (e) {
      Get.dialog(ErrorAlert(
          msg: e.toString(),
          methodName: "fetchTodayAttendance | api_controller.dart"));
    }
  }

  // ===== Utils

  Future curLocations() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }
}
