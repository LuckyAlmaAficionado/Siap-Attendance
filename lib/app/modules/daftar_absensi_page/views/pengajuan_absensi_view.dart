import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:talenta_app/app/controllers/authentication_controller.dart';
import 'package:talenta_app/app/controllers/date_controller.dart';
import 'package:talenta_app/app/controllers/file_picker_controller.dart';
import 'package:talenta_app/app/models/user_absensi.dart';
import 'package:talenta_app/app/modules/daftar_absensi_page/controllers/daftar_absensi_page_controller.dart';
import 'package:talenta_app/app/shared/theme.dart';
import 'package:talenta_app/app/shared/utils.dart';

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

  final controller = Get.put(DaftarAbsensiPageController());
  final dateController = Get.put(DateController());
  final filePicker = Get.put(FilePickerController());
  final authC = Get.find<AuthenticationController>();

  DateTime? picked;
  late List<UserAbsensi> absensi;
  late UserAbsensi currentTime;

  late UserAbsensi tempClockIn;
  late UserAbsensi tempClockOut;

  @override
  void initState() {
    super.initState();
    absensi = authC.listUserAbsensi;
  }

  findAbsensiByDate() {
    print(absensi
        .where((element) => element.createdAt!.day == picked!.day)
        .isBlank);

    if (absensi
        .where((element) =>
            element.createdAt!.day == picked!.day &&
            element.createdAt!.month == picked!.month &&
            element.createdAt!.year == picked!.year)
        .isNotEmpty) {
      absensi
          .where((element) =>
              element.createdAt!.day == picked!.day &&
              element.createdAt!.month == picked!.month &&
              element.createdAt!.year == picked!.year)
          .forEach((element) {
        print("${element.type} jam ${element.createdAt}");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Pengajuan Absensi',
            style: appBarTextStyle,
          ),
          centerTitle: true,
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
                  TextFormField(
                    controller: timeController,
                    onTap: () async {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      picked = await dateController.selectDate(context);
                      timeController.text =
                          DateFormat("dd MMM yyyy", "id_ID").format(picked!);

                      setState(() {});
                      findAbsensiByDate();
                    },
                    decoration: InputDecoration(
                      labelText: 'Pick a date',
                      labelStyle: darkGreyTextStyle,
                      suffixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true, // Jadikan text field hanya bisa dibaca
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(
                      "Pilih shift",
                      style: blackTextStyle,
                    ),
                    subtitle: Text(
                      "Office 2 (${DateFormat("HH:MM").format(DateTime.now())} - ${DateFormat("HH:MM").format(DateTime.now())})",
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
                              "07:38",
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
                              "-",
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
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: Checkbox(
                      onChanged: (value) {
                        setState(() {
                          clockIn = value!;
                        });
                      },
                      value: clockIn,
                    ),
                    title: Text(
                      "Clock In",
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    subtitle: TextField(
                      decoration: InputDecoration(
                        hintText: 'Jam',
                        hintStyle: darkGreyTextStyle,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: darkGreyColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: Checkbox(
                      onChanged: (value) {
                        setState(() {
                          clockOut = value!;
                        });
                      },
                      value: clockOut,
                    ),
                    title: Text(
                      "Clock Out",
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    subtitle: TextField(
                      decoration: InputDecoration(
                        hintText: 'Jam',
                        hintStyle: darkGreyTextStyle,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: darkGreyColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  TextField(
                    decoration: InputDecoration(
                        hintText: "Deksripsi",
                        hintStyle: darkGreyTextStyle,
                        prefixIcon: Icon(Icons.format_align_left_outlined),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: darkGreyColor,
                          ),
                        )),
                  ),
                  const Gap(10),
                  GestureDetector(
                    onTap: () async {
                      path = await filePicker.openFileExplorerPDF();
                      setState(() {});
                    },
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(
                        "Unggah file",
                        style: blackTextStyle,
                      ),
                      subtitle: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.task_outlined),
                          hintText: (path.isEmpty)
                              ? "Max file 10 mb (click here..!)"
                              : path.split("/").last,
                          hintMaxLines: 2,
                          hintStyle: darkGreyTextStyle,
                        ),
                      ),
                    ),
                  ),
                  const Gap(80),
                ],
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: CustomButton(
                title: "Kirim pengajuan",
                onTap: () {},
              ),
            ),
          ],
        ));
  }
}
