import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:talenta_app/app/controllers/api_controller.dart';
import 'package:talenta_app/app/controllers/model_controller.dart';
import 'package:talenta_app/app/models/user_shift_setting_model.dart';

class CalendarController extends GetxController {
  final List<Map<String, dynamic>> events = [];
  List<Map<String, dynamic>> _dateRange = [];

  DateTime startDate = DateTime.now();
  List<UserShiftSettingModel> customDayOff = [];
  final m = Get.find<ModelController>();

  @override
  void onInit() async {
    super.onInit();
  }

  Future _generateCalendar(int year) async {
    _dateRange = [];
    DateTime currentDate = DateTime.parse(m.startDate);
    int dayOffIndex = 0; // Start with the first index of customDayOff
    int lenght = currentDate.difference(DateTime.now()).inDays * -1;
    for (int i = 0; i <= lenght; i++) {
      bool isDayOff = customDayOff[dayOffIndex].dayoff == 1;
      _dateRange.add({
        'date': currentDate,
        'isDayOff': isDayOff,
        'events': [], // Initialize with an empty list of events
      });

      currentDate = currentDate.add(const Duration(days: 1));
      dayOffIndex = (dayOffIndex + 1) % customDayOff.length;
    }

    log("dayOffIndex: $dayOffIndex");
    await m.shiftC(customDayOff[dayOffIndex]);
  }

  void addEvent(DateTime date, String event) {
    for (var item in _dateRange) {
      if (item['date'].year == date.year &&
          item['date'].month == date.month &&
          item['date'].day == date.day) {
        item['events'].add(event);
        if (event.toLowerCase().contains("libur")) {
          item['isDayOff'] = true;
        }
        break;
      }
    }
  }

  void checkDateStatus(DateTime date) async {
    log("=== checkDateStatus ====");
    customDayOff = await Get.put(ApiController()).fetchShifts();
    await _generateCalendar(date.year);
    for (var item in _dateRange) {
      if (item['date'].year == date.year &&
          item['date'].month == date.month &&
          item['date'].day == date.day) {
        bool isDayOff = item['isDayOff'];
        List<dynamic> events = item['events'];
        String status = isDayOff ? 'Hari Libur' : 'Hari Kerja';
        String eventText = events.isNotEmpty
            ? 'Event: ${events.join(', ')}'
            : 'Tidak ada event';

        log("Status Tanggal: ${DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(date)}\n$status\n$eventText");
        break;
      }
    }
  }
}
