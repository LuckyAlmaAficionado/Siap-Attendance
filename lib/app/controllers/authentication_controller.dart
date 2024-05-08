import 'dart:convert';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:talenta_app/app/models/user_absensi.dart';
import 'package:talenta_app/app/models/users.dart';
import 'package:talenta_app/app/routes/app_pages.dart';
import 'package:talenta_app/app/shared/error_alert.dart';
import 'package:talenta_app/app/shared/utils.dart';

import 'date_controller.dart';

class AuthenticationController extends GetxController {
  final _prefs = SharedPreferences.getInstance();
  final dio = Dio();

  RxBool isNeededPinWhenOpenApps = false.obs;
  RxBool isAuthenticationOn = false.obs;
  RxBool isPinActivated = false.obs;
  RxBool autoLoginC = false.obs;
  RxString pin = "".obs;
  String token = "";
  Rx<UserAbsensi?> clockInEntry = Rx<UserAbsensi?>(null);
  Rx<UserAbsensi?> clockOutEntry = Rx<UserAbsensi?>(null);
  Rx<User?> data = Rx<User?>(null);
  String BASE_URL = "https://backend-siap-production.up.railway.app";
  // String BASE_URL = "http://192.168.5.9:41016";
  RxList<UserAbsensi> listUserAbsensi = <UserAbsensi>[].obs;
  RxString jabatan = "".obs;
  late bool isSuperAdmin = true;

  @override
  void onInit() async {
    super.onInit();
    await autoLoginIsTrue();
    await validatorPIN();
    Get.put(DateController()).fetchHolidayDate();
    validatorPIN();
  }

  Future fetchDetailAbsensi() async {
    try {
      if (token.isNotEmpty) {
        final res = await http.get(
          Uri.parse(
              "$BASE_URL/api/v1/absensi/detail/${data.value!.data.user.id}"),
          headers: {"Authorization": "Bearer $token"},
        );

        if (res.statusCode == 200) {
          List temp = json.decode(res.body);

          return listUserAbsensi(
              List<UserAbsensi>.from(temp.map((e) => UserAbsensi.fromJson(e))));
        }
      } else {
        return listUserAbsensi.clear();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  autoLoginIsTrue() async {
    try {
      SharedPreferences pref = await _prefs;
      if (pref.containsKey("email") && pref.containsKey("password")) {
        await fetchUser(pref.getString("email")!, pref.getString("password")!);
        await fetchDataAbsensi(data.value!.data.user.id!);
        // await fetchDetailAbsensi();
        autoLoginC(true);
        return true;
      }
      return false;
    } catch (e) {
      Get.dialog(ErrorAlert(text: e.toString()));
    }
  }

  Future<void> autoLogin() async {
    SharedPreferences pref = await _prefs;
    if (pref.containsKey("email") && pref.containsKey("password")) {
      String sharedEmail = pref.getString("email")!;
      String sharedPassword = pref.getString("password")!;
      signIn(sharedEmail, sharedPassword);
    }
  }

  Future<void> saveAccount(String email, String password) async {
    SharedPreferences pref = await _prefs;
    pref.setString("email", email);
    pref.setString("password", password);
  }

  Future<bool> isUserLoggedIn() async {
    SharedPreferences pref = await _prefs;
    return pref.containsKey('token');
  }

  Future signIn(String email, String password) async {
    try {
      SharedPreferences pref = await _prefs;
      pref.remove("token");

      bool result = await fetchUser(email, password);

      if (result) {
        fetchDataAbsensi(data.value!.data.user.id!).then((value) {
          Get.back();
          Get.offAllNamed(Routes.DASHBOARD_PAGE);
        });
      } else {
        Get.back();
        Utils().snackbarC("Oh Tidak!", "Password atau Email salah", false);
      }
    } catch (e) {
      Get.back();
      Utils().snackbarC("Oh Tidak!", "Password atau Email salah", false);
      throw Exception(e);
    }
  }

  Future fetchUser(String email, String password) async {
    try {
      SharedPreferences pref = await _prefs;
      pref.remove("token");

      Map<String, dynamic> body = {"email": "$email", "password": "$password"};

      final response =
          await dio.post("$BASE_URL/api/v1/auth/login", data: body);

      if (response.statusCode == 200) {
        data(User.fromJson(response.data));
        jabatan(data.value!.data.jabatan);
        this.token = data.value!.data.token;

        saveAccount(email, password);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Get.dialog(ErrorAlert(text: e.toString()));
    }
  }

  Future<void> fetchDataAbsensi(String userId) async {
    try {
      final response = await http.post(
        Uri.parse("$BASE_URL/api/v1/absensi/$userId"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 204) {
        clockInEntry.value = null;
        clockOutEntry.value = null;
      } else if (response.statusCode == 200) {
        List<UserAbsensi> req = await Isolate.run(() {
          List<dynamic> responseData = jsonDecode(response.body);
          return responseData.map((e) => UserAbsensi.fromJson(e)).toList();
        });

        clockInEntry.value =
            req.firstWhereOrNull((element) => element.type == "clockin");
        clockOutEntry.value =
            req.firstWhereOrNull((element) => element.type == "clockout");
      } else {
        print("Failed to fetch data: ${response.statusCode}");
        clockInEntry.value = null;
        clockOutEntry.value = null;
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  fetchDataUser() async {
    final response = await dio.get("$BASE_URL/api/v1/auth/detail");

    if (response.statusCode == 200) {
      List<dynamic> responseData = response.data;
      responseData.map((item) => User.fromJson(item)).toList();
    }
  }

  Future<bool> validatorPIN() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? isNeededPinWhenOpenAppsValue =
        prefs.getBool('isNeededPinWhenOpenApps');
    bool? isOauthenticationOnValue = prefs.getBool("isAuthenticationOn");
    bool? isPinActivatedValue = prefs.getBool('isPinActivated');
    String? pinValue = prefs.getString('pin');

    if (isPinActivatedValue != null &&
        isNeededPinWhenOpenAppsValue != null &&
        pinValue != null) {
      isNeededPinWhenOpenApps(isNeededPinWhenOpenAppsValue);
      isAuthenticationOn(isOauthenticationOnValue);
      isPinActivated(isPinActivatedValue);
      pin(pinValue);

      return isNeededPinWhenOpenAppsValue;
    } else {
      initializedValidator();
      return false;
    }
  }

  void initializedValidatorAuthentication() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isAuthenticationOn", !isAuthenticationOn.value);
    validatorPIN();
  }

  void initializedValidator() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isNeededPinWhenOpenApps', false);
    prefs.setBool("isAuthenticationOn", false);
    prefs.setBool('isPinActivated', false);
    prefs.setString('pin', "");
    validatorPIN();
  }

  Future<void> savePin(String pin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isPinActivated', true);
    prefs.setBool('isNeededPinWhenOpenApps', isNeededPinWhenOpenApps.value);
    prefs.setString('pin', pin);
    validatorPIN();
  }

  Future<bool> getPin(String pin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedPin = prefs.getString('pin');
    return storedPin == pin;
  }

  Future<void> resetPin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    initializedValidator();
  }

  Future<void> usePinWhenOpenApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(
        'isNeededPinWhenOpenApps', isNeededPinWhenOpenApps.toggle().value);
    prefs.setBool('isPinActivated', isPinActivated.value);
    prefs.setString('pin', pin.value);
    validatorPIN();
  }

  validatorPinWhenOpenApps() {
    (isNeededPinWhenOpenApps.value)
        ? Get.toNamed(Routes.VALIDATOR_PIN)
        : Get.toNamed(Routes.DASHBOARD_PAGE);
  }
}
