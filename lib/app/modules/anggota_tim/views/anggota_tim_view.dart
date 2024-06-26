// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:talenta_app/app/shared/images/images.dart';

import 'package:talenta_app/app/shared/theme.dart';

import '../controllers/anggota_tim_controller.dart';

class AnggotaTimView extends GetView<AnggotaTimController> {
  const AnggotaTimView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Anggota Tim',
            style: appBarTextStyle,
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            // ...
            FutureBuilder(
              future: controller.fetchHolidayDate(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                      height: Get.height * 0.5,
                      width: Get.width,
                      child: Center(child: CircularProgressIndicator()));
                } else if (snapshot.hasData) {
                  List<DateTime> tanggal = snapshot.data;

                  return Obx(
                    () => Container(
                      width: Get.width,
                      height: Get.height * 0.7,
                      padding: const EdgeInsets.only(top: 10),
                      child: TableCalendar(
                        locale: "id_ID",
                        firstDay: DateTime(2020, 3, 14),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: controller.dateValue.value,
                        currentDay: controller.dateValue.value,
                        headerVisible: true,
                        startingDayOfWeek: StartingDayOfWeek.sunday,
                        calendarBuilders: CalendarBuilders(
                          markerBuilder: (context, day, events) {
                            tanggal.forEach((element) {
                              if (element.year == 2024 && element.month == 4) {
                                log("message: ${element}");
                              }
                            });

                            if (tanggal.any((element) =>
                                (element.day == day.day &&
                                    element.month == day.month &&
                                    element.year == day.year)))
                              return Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red.withOpacity(0.1),
                                ),
                              );
                            return null;
                          },
                        ),
                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          titleTextStyle: normalTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                          leftChevronVisible: false,
                          rightChevronVisible: false,
                        ),
                        calendarStyle: CalendarStyle(
                          todayTextStyle: GoogleFonts.lexend(
                            color: blueColor,
                            fontSize: 16,
                          ),
                          todayDecoration: BoxDecoration(
                            color: whiteColor,
                            border: Border.all(width: 1, color: blueColor),
                            shape: BoxShape.circle,
                          ),
                          tablePadding: const EdgeInsets.only(top: 10),
                          defaultTextStyle: GoogleFonts.lexend(),
                          selectedTextStyle: whiteTextStyle,
                          weekendTextStyle: redTextStyle,
                          outsideDaysVisible: false,
                          isTodayHighlighted: true,
                        ),
                        onDaySelected: (selectedDay, focusedDay) {
                          controller.dateValue(selectedDay);
                          if (controller.googleCalendar.any((element) =>
                              (element.start.date.day == selectedDay.day &&
                                  element.start.date.month ==
                                      selectedDay.month &&
                                  element.start.date.year ==
                                      selectedDay.year))) {
                            print(controller.findByDate(selectedDay));
                          }
                        },
                        // onDaySelected: (selectedDay, focusedDay) =>
                        //     controller.dateValue.value = selectedDay,
                      ),
                    ),
                  );
                }

                return Container(
                  color: Colors.red,
                );
              },
            ),

            // ...
            DraggableScrollableSheet(
              maxChildSize: 0.8,
              minChildSize: 0.32,
              initialChildSize: 0.45,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  physics: BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.fast,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: whiteColor,
                    ),
                    width: Get.width,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(100)),
                          width: context.width * 0.2,
                          height: context.height * 0.005,
                        ),
                        const Gap(15),
                        Container(
                          width: Get.width,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Obx(
                            () => SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  3,
                                  (index) => GestureDetector(
                                    onTap: () =>
                                        controller.curIndex.value = index,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      margin: const EdgeInsets.only(right: 15),
                                      height: 30,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color:
                                            (controller.curIndex.value == index)
                                                ? blueColor
                                                : darkGreyColor.withAlpha(30),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: Text(
                                        "${controller.subOpsi[index]}",
                                        style:
                                            (controller.curIndex.value == index)
                                                ? whiteTextStyle
                                                : normalTextStyle,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Gap(10),
                        Container(
                          width: Get.width,
                          height: Get.height * 0.62,
                          child: ListView.builder(
                            itemCount: 7,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              RxBool isChange = false.obs;

                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ExpansionTile(
                                      onExpansionChanged: (value) {
                                        isChange.toggle();
                                      },
                                      backgroundColor: whiteColor,
                                      children: [
                                        ListTile(
                                          leading: Icon(
                                            Boxicons.bx_time,
                                            color: Colors.green,
                                          ),
                                          title: Row(
                                            children: [
                                              Text(
                                                "08:06",
                                                style: normalTextStyle.copyWith(
                                                  fontWeight: regular,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              const Gap(10),
                                              Text(
                                                "Clock-In",
                                                style: normalTextStyle.copyWith(
                                                  fontWeight: regular,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ListTile(
                                          leading: Icon(
                                            Boxicons.bx_time_five,
                                            color: Colors.red,
                                          ),
                                          title: Row(
                                            children: [
                                              Text(
                                                "16:51",
                                                style: normalTextStyle.copyWith(
                                                  fontWeight: regular,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              const Gap(10),
                                              Text(
                                                "Clock-Out",
                                                style: normalTextStyle.copyWith(
                                                  fontWeight: regular,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                      leading: ImageNetwork(url: "###"),
                                      trailing: Obx(() => Icon(
                                            (isChange.value)
                                                ? Boxicons.bx_minus_circle
                                                : Boxicons.bx_plus_circle,
                                          )),
                                      title: Text(
                                        "Adhymas Fajar Sudrajad",
                                        style: normalTextStyle.copyWith(
                                          fontWeight: regular,
                                          fontSize: 14,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Gap(5),
                                          Text(
                                            "Programmer",
                                            style: normalTextStyle.copyWith(
                                              fontWeight: regular,
                                              color: darkGreyColor,
                                              fontSize: 11,
                                            ),
                                          ),
                                          const Gap(5),
                                          Row(
                                            children: [
                                              Icon(
                                                Boxicons.bx_time,
                                                color: greenColor,
                                              ),
                                              const Gap(10),
                                              Text(
                                                "08:06",
                                                style: normalTextStyle.copyWith(
                                                  fontWeight: medium,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const Gap(40),
                                              Icon(
                                                Boxicons.bx_time_five,
                                                color: blueColor,
                                              ),
                                              const Gap(10),
                                              Text(
                                                "16:51",
                                                style: normalTextStyle.copyWith(
                                                  fontWeight: medium,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ));
  }
}
