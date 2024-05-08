import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../models/google_calendar.dart';

class AnggotaTimController extends GetxController {
  Rx<DateTime> dateValue = DateTime.now().obs;
  RxList<DateTime> listDateTime = <DateTime>[].obs;
  RxList<GoogleCalendarModel> googleCalendar = <GoogleCalendarModel>[].obs;
  RxString s = "".obs;
  RxInt curIndex = 0.obs;
  List<DateTime> value = [];

  List<String> subOpsi = [
    "All activities",
    "On leave",
    "Clock in",
  ];

  @override
  void onInit() async {
    s.value = DateTime.now().toIso8601String();
    // value = await fetchHolidayDate();
    super.onInit();
  }

  Future fetchDateFromInternet() async {
    final dio = Dio();

    try {
      final res = await dio.get(
          "https://www.googleapis.com/calendar/v3/calendars/id.indonesian%23holiday@group.v.calendar.google.com/events?key=AIzaSyAgswKdqQrBGikVZ40r7pNrOLpaMZ4hWmk");

      if (res.statusCode == 200) {
        List temp = res.data['items'];
        googleCalendar(
            temp.map((e) => GoogleCalendarModel.fromJson(e)).toList());

        listDateTime.value = googleCalendar.map((e) => e.start.date).toList();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  findByDate(DateTime selectedDay) => googleCalendar
      .where(
        (element) => (element.start.date.day == selectedDay.day &&
            element.start.date.month == selectedDay.month &&
            element.start.date.year == selectedDay.year),
      )
      .first
      .summary;

  Future fetchHolidayDate() async {
    if (listDateTime.isEmpty) await fetchDateFromInternet();
    return listDateTime.toList();
  }
}
