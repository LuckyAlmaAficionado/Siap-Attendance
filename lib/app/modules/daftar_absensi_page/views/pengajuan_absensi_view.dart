import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:talenta_app/app/controllers/calendar_controller.dart';

import 'package:talenta_app/app/controllers/date_controller.dart';
import 'package:talenta_app/app/controllers/file_picker_controller.dart';
import 'package:talenta_app/app/controllers/model_controller.dart';
import 'package:talenta_app/app/models/user_absensi.dart';
import 'package:talenta_app/app/modules/daftar_absensi_page/controllers/daftar_absensi_page_controller.dart';
import 'package:talenta_app/app/shared/button/button_1.dart';
import 'package:talenta_app/app/shared/textfield/textfield_1.dart';
import 'package:talenta_app/app/shared/theme.dart';

class PengajuanAbsensiView extends StatefulWidget {
  PengajuanAbsensiView({Key? key}) : super(key: key);

  @override
  State<PengajuanAbsensiView> createState() => _PengajuanAbsensiViewState();
}

class _PengajuanAbsensiViewState extends State<PengajuanAbsensiView> {
  bool clockIn = false;
  bool clockOut = false;
  String path = "";

  TextEditingController timeController = TextEditingController();

  TextEditingController clockInC = TextEditingController();
  TextEditingController clockOutC = TextEditingController();

  final controller = Get.put(DaftarAbsensiPageController());
  final dateController = Get.put(DateController());
  final calendarC = Get.put(CalendarController());
  final filePicker = Get.put(FilePickerController());

  final m = Get.find<ModelController>();

  DateTime now = DateTime.now();
  DateTime picked = DateTime.now();
  late List<ModelAbsensi> absensi;
  late ModelAbsensi currentTime;

  ModelAbsensi tempClockIn = ModelAbsensi();
  ModelAbsensi tempClockOut = ModelAbsensi();

  @override
  void initState() {
    super.initState();
  }

  findAbsensiByDate() {
    tempClockIn = m.a.firstWhere(
      (element) =>
          element.createdAt!.day == picked.day &&
          element.createdAt!.month == picked.month &&
          element.createdAt!.year == picked.year &&
          element.type == "Clock-In",
      orElse: () => ModelAbsensi(),
    );

    tempClockOut = m.a.firstWhere(
      (element) =>
          element.createdAt!.day == picked.day &&
          element.createdAt!.month == picked.month &&
          element.createdAt!.year == picked.year &&
          element.type == "Clock-Out",
      orElse: () => ModelAbsensi(),
    );
  }

  String formatTime(String time) {
    DateTime dateTime = DateFormat('HH:mm:ss').parse(time);
    return DateFormat('HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Pengajuan Absensi',
            style: appBarTextStyle.copyWith(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: false,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              height: Get.height,
              padding: const EdgeInsets.all(20),
              width: Get.width,
              child: ListView(
                padding: const EdgeInsets.all(0),
                children: [
                  // ... pilih tanggal

                  TextField1(
                    controller: timeController,
                    onTap: () async {
                      picked = await dateController.selectDate(context, picked);
                      timeController.text =
                          DateFormat("dd MMMM yyyy", "id_ID").format(picked);
                      setState(() {
                        findAbsensiByDate();
                      });
                    },
                    suffixIcon: HeroIcon(HeroIcons.calendarDays),
                    readOnly: true,
                  ),
                  // TextFormField(
                  //   controller: timeController,
                  //   onTap: () async {
                  //     FocusScope.of(context).requestFocus(new FocusNode());
                  //     picked = await dateController.selectDate(context, picked);
                  //     timeController.text =
                  //         DateFormat("dd MMM yyyy", "id_ID").format(picked);

                  //     setState(() {
                  //       findAbsensiByDate();
                  //     });
                  //   },
                  //   decoration: InputDecoration(
                  //     labelText: 'Pick a date',
                  //     labelStyle: darkGreyTextStyle,
                  //     suffixIcon: Icon(Icons.calendar_today),
                  //     border: OutlineInputBorder(),
                  //   ),
                  //   readOnly: true, // Jadikan text field hanya bisa dibaca
                  // ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(
                      "Pilih shift",
                      style: blackTextStyle,
                    ),
                    subtitle: Text(
                      "${m.shiftC.value.shiftName} (${formatTime(m.shiftC.value.scheduleIn!)} - ${formatTime(m.shiftC.value.scheduleOut!)})",
                      style: darkGreyTextStyle,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Clock In",
                              style: blackTextStyle,
                            ),
                            const Gap(4),
                            Text(
                              tempClockIn.id != null
                                  ? "${DateFormat("HH:mm", "id_ID").format(tempClockIn.createdAt!)}"
                                  : " - ",
                              style: darkGreyTextStyle,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Clock Out",
                              style: blackTextStyle,
                            ),
                            const Gap(4),
                            Text(
                              tempClockOut.id != null
                                  ? "${DateFormat("HH:mm").format(tempClockOut.createdAt!)}"
                                  : " - ",
                              style: darkGreyTextStyle,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: darkGreyColor,
                  ),
                  const Gap(10),
                  Row(
                    children: [
                      Checkbox(
                        value: (!clockInC.text.isEmpty),
                        onChanged: (value) {
                          setState(() {
                            clockInC.text = "";
                          });
                        },
                      ),
                      Flexible(
                        child: TextField1(
                          controller: clockInC,
                          onTap: () async {
                            TimeOfDay? picker = await showTimePicker(
                              context: context,
                              initialEntryMode: TimePickerEntryMode.dial,
                              initialTime: TimeOfDay.now(),
                            );
                            setState(() {
                              clockInC.text = DateFormat("HH:MM").format(
                                  DateTime(
                                      picked.day,
                                      picked.month,
                                      picked.year,
                                      picker!.hour,
                                      picker.minute));
                            });
                          },
                          readOnly: true,
                          suffixIcon: HeroIcon(HeroIcons.clock),
                          hintText: "Clock-In",
                          fillColor: (clockInC.text.isEmpty)
                              ? lightGreyColor
                              : Colors.blue.shade50,
                          onChanged: (p0) {},
                        ),
                      )
                    ],
                  ),
                  const Gap(10),

                  Row(
                    children: [
                      Checkbox(
                        value: (!clockOutC.text.isEmpty),
                        onChanged: (value) {
                          setState(() {
                            clockOutC.text = "";
                          });
                        },
                      ),
                      Flexible(
                        child: TextField1(
                          controller: clockOutC,
                          onTap: () async {
                            TimeOfDay? picker = await showTimePicker(
                              context: context,
                              initialEntryMode: TimePickerEntryMode.dial,
                              initialTime: TimeOfDay.now(),
                            );
                            setState(() {
                              clockOutC.text = DateFormat("HH:MM").format(
                                  DateTime(
                                      picked.day,
                                      picked.month,
                                      picked.year,
                                      picker!.hour,
                                      picker.minute));
                            });
                          },
                          readOnly: true,
                          hintText: "Clock-Out",
                          suffixIcon: HeroIcon(HeroIcons.clock),
                          fillColor: (clockOutC.text.isEmpty)
                              ? lightGreyColor
                              : Colors.blue.shade50,
                          onChanged: (p0) {
                            setState(() {});
                          },
                        ),
                      )
                    ],
                  ),

                  const Gap(10),
                  TextField1(
                    maxLines: 4,
                    hintText: "Deskripsi",
                    suffixIcon: Icon(Icons.description_outlined),
                  ),

                  const Gap(10),
                  TextField1(
                    hintText: "Max file 5mb (click here..!)",
                    suffixIcon: Icon(Icons.file_download_outlined),
                    readOnly: true,
                    onTap: () async {
                      path = await filePicker.openFileExplorerPDF();
                      setState(() {});
                    },
                  ),

                  const Gap(80),
                ],
              ),
            ),
            Positioned(
              left: 10,
              right: 10,
              bottom: 10,
              child: Button1(
                title: "Kirim pengajuan",
                onTap: () {},
              ),
            ),
          ],
        ));
  }
}
