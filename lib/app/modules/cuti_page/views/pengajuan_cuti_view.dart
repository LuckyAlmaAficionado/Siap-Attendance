import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:talenta_app/app/controllers/camera_data_controller.dart';
import 'package:talenta_app/app/modules/cuti_page/controllers/cuti_page_controller.dart';
import 'package:talenta_app/app/shared/textfield/textfield_1.dart';
import 'package:talenta_app/app/shared/theme.dart';
import 'package:talenta_app/app/shared/utils.dart';

import '../../home/views/home_view.dart';

class PengajuanCutiView extends StatefulWidget {
  const PengajuanCutiView({super.key});

  @override
  State<PengajuanCutiView> createState() => _PengajuanCutiViewState();
}

class _PengajuanCutiViewState extends State<PengajuanCutiView> {
  final cutiC = Get.put(CutiPageController());
  final cameraC = Get.put(CameraDataController());

  TextEditingController date = TextEditingController();
  TextEditingController si = TextEditingController();
  TextEditingController fl = TextEditingController();
  DateTimeRange? sd = DateTimeRange(start: DateTime.now(), end: DateTime.now());

  RxString imgPath = "".obs;

  String jenisCutiController = "Jenis Cuti";

  String firstDate = "";
  String lastDate = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Pengajuan Cuti",
          style: appBarTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 15),
            TextField1(
              controller: si,
              onTap: () async {
                await jenisCuti();
                setState(() {});
              },
              preffixIcon: Icon(Iconsax.note_1),
              readOnly: true,
              hintText: "Jenis Cuti",
              suffixIcon: Icon(Iconsax.arrow_bottom),
            ),

            const Gap(15),

            TextField1(
              controller: date,
              readOnly: true,
              onTap: () async {
                sd = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(DateTime.now().year),
                  lastDate: DateTime(DateTime.now().year + 1),
                );

                firstDate =
                    DateFormat("dd MMMM yyyy", "id_ID").format(sd!.start);
                lastDate = DateFormat("dd MMMM yyyy", "id_ID").format(sd!.end);

                date.text = "$firstDate - $lastDate";
                setState(() {});
              },
              hintText: "Pilih tanggal",
              preffixIcon: Icon(Iconsax.calendar_1),
            ),
            const Gap(15),
            TextField1(
              preffixIcon: Icon(Iconsax.note),
              hintText: "Alasan",
            ),
            const Gap(15),
            TextField1(
              hintText: "Dilegasi ke (opsional)",
              preffixIcon: Icon(Iconsax.people),
              suffixIcon: Icon(Iconsax.arrow_bottom),
              onTap: () => dilegasi(),
              readOnly: true,
            ),

            // ..
            const Gap(15),
            TextField1(
              controller: fl,
              hintText: "Input file (uk max. 10mb)",
              readOnly: true,
              preffixIcon: Icon(Iconsax.task_square),
              onTap: () async {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  builder: (context) => Container(
                    width: Get.width,
                    height: 110,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            fl.text =
                                (await cameraC.pickImage(ImageSource.camera))
                                    .path;
                            setState(() {});
                          },
                          child: IconWidgetService(
                            Iconsax.camera,
                            "Kamera",
                            greenColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            fl.text =
                                (await cameraC.pickImage(ImageSource.gallery))
                                    .path;
                            setState(() {});
                          },
                          child: IconWidgetService(
                            Iconsax.gallery,
                            "Galeri",
                            Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 50),
            CustomButton(
              title: "Kirim pengajuan",
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }

  dilegasi() async => await showModalBottomSheet(
        context: context,
        enableDrag: true,
        isScrollControlled: true,
        builder: (context) => Container(
          height: Get.height * 0.9,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.close,
                      color: darkGreyColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Dilegasi Ke",
                    style: normalTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),

              // ... textfield
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(0),
                    hintText: "Cari...",
                    hintStyle: darkGreyTextStyle.copyWith(
                      fontWeight: extraLight,
                    ),
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 1,
                        color: darkGreyColor,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
              // ... jenis cuti
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: List.generate(
                    cutiC.tipeCuti.length,
                    (index) => ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      onTap: () {
                        jenisCutiController = cutiC.tipeCuti[index];
                        Get.back();
                      },
                      title: Text(
                        "293 - Lucky Alma Aficionado Rigel",
                        style: normalTextStyle.copyWith(fontWeight: medium),
                      ),
                      subtitle: Text(
                        "Programmer",
                        style: normalTextStyle.copyWith(
                          fontSize: 12,
                          color: darkGreyColor,
                        ),
                      ),
                      minLeadingWidth: 10,
                      leading: CircleAvatar(),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );

  jenisCuti() async => await showModalBottomSheet(
        context: context,
        enableDrag: true,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: Get.height * 0.8,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.close,
                        color: darkGreyColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Tipe cuti",
                      style: normalTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // ... textfield
                SizedBox(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0),
                      hintText: "Cari...",
                      hintStyle: darkGreyTextStyle.copyWith(
                        fontWeight: extraLight,
                      ),
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 1, color: darkGreyColor),
                      ),
                    ),
                  ),
                ),

                // ... jenis cuti
                Expanded(
                  child: ListView(
                    children: List.generate(
                      cutiC.tipeCuti.length,
                      (index) => ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        onTap: () {
                          si.text = cutiC.tipeCuti[index];
                          Get.back();
                        },
                        title: Text(
                          cutiC.tipeCuti[index],
                          style: normalTextStyle,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      );
}

// ignore: must_be_immutable
class CustomTextfield extends StatelessWidget {
  CustomTextfield({
    super.key,
    this.controller,
    required this.hint,
    required this.prefix,
    this.suffix,
  });

  TextEditingController? controller;
  final String hint;
  final IconData prefix;
  IconData? suffix;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: normalTextStyle.copyWith(
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: darkGreyTextStyle,
        prefixIcon: Icon(
          prefix,
          color: darkGreyColor,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        suffixIcon: Icon(
          suffix,
          color: darkGreyColor,
        ),
      ),
    );
  }
}
