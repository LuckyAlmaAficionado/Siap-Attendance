import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:talenta_app/app/models/google_calendar.dart';

class DateController extends GetxController {
  List<DateTime> holidays = [];
  List<GoogleCalendarModel> result = [];

  Future filterMonthAndYear() async {
    await fetchHolidayDate();
    final currentMonth = DateTime.now().month;
    final currentYear = DateTime.now().year;

    final currentMonthEvents = result.where((event) {
      final startDate = event.start.date;
      return startDate.month == currentMonth && startDate.year == currentYear;
    }).toList();

    // Urutkan acara-acara berdasarkan tanggal mulai
    currentMonthEvents.sort((a, b) => a.start.date.compareTo(b.start.date));

    List<GoogleCalendarModel> filteredEvents = [];
    for (var event in currentMonthEvents) {
      filteredEvents.add(event);
    }

    return filteredEvents;
  }

  Future fetchHolidayDate() async {
    final dio = Dio();

    try {
      final res = await dio.get(
          "https://www.googleapis.com/calendar/v3/calendars/id.indonesian%23holiday@group.v.calendar.google.com/events?key=AIzaSyAgswKdqQrBGikVZ40r7pNrOLpaMZ4hWmk");

      if (res.statusCode == 200) {
        List temp = res.data['items'];
        result = temp.map((e) => GoogleCalendarModel.fromJson(e)).toList();

        holidays = result.map((element) {
          return element.start.date;
        }).toList();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<DateTime> pickerDateTime(BuildContext context) async {
    DateTime? picker = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
      initialDate: DateTime.now(),
    );

    if (picker != null) return picker;

    return DateTime.now();
  }

  Future<DateTime> selectDate(BuildContext context) async {
    // ... mendapatkan tanggal
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      // ... jika ada tanggal yang dipilih
      return picked;
    }

    // ... jika tidak ada tanggal yang dipilih
    return DateTime.now();
  }
}
