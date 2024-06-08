import 'package:get/get.dart';

import 'package:talenta_app/app/models/karyawan.dart';
import 'package:talenta_app/app/models/locations.dart';
import 'package:talenta_app/app/models/model_izin.dart';
import 'package:talenta_app/app/models/user_absensi.dart';
import 'package:talenta_app/app/models/user_job.dart';
import 'package:talenta_app/app/models/user_schedule_setting_model.dart';
import 'package:talenta_app/app/models/user_shift_setting_model.dart';
import 'package:talenta_app/app/models/users.dart';

class ModelController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
  }

  Rx<ModelUser?> u = Rx<ModelUser?>(ModelUser());
  RxList<Karyawan> k = <Karyawan>[].obs;

  Rx<UserJobModel> job = Rx<UserJobModel>(UserJobModel());
  Rx<ModelAbsensi> ci = Rx<ModelAbsensi>(ModelAbsensi());
  Rx<ModelAbsensi> co = Rx<ModelAbsensi>(ModelAbsensi());
  Rx<UserShiftSettingModel> shiftC =
      Rx<UserShiftSettingModel>(UserShiftSettingModel());

  RxList<ModelIzin> i = <ModelIzin>[].obs;
  RxList<ModelAbsensi> a = <ModelAbsensi>[].obs;
  RxList<ModelLocations> ml = <ModelLocations>[].obs;

  RxList<UserScheduleSettingModel> scheduleSetting =
      <UserScheduleSettingModel>[].obs;
  RxList<UserShiftSettingModel> shiftSetting = <UserShiftSettingModel>[].obs;

  RxList<int> dayOffPattern = <int>[].obs;

  // pin
  RxString pinC = "".obs;

  // ======================= SAVE ID

  String userId = "";
  String shiftId = "";
  String scheduleId = "";
  String startDate = "";

  // =========== approval
  String apprAbsensi = "";
  String apprShift = "";
  String apprLembur = "";
  String apprIzinKembali = "";
  String apprIstirahatTelat = "";
}
