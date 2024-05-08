import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:talenta_app/app/controllers/camera_data_controller.dart';
import 'package:talenta_app/app/modules/cuti_page/controllers/cuti_page_controller.dart';
import 'package:talenta_app/app/shared/theme.dart';
import 'package:talenta_app/app/shared/utils.dart';

import '../../dashboard_page/views/dashboard_view.dart';

class PengajuanCutiView extends StatefulWidget {
  const PengajuanCutiView({super.key});

  @override
  State<PengajuanCutiView> createState() => _PengajuanCutiViewState();
}

class _PengajuanCutiViewState extends State<PengajuanCutiView> {
  final cutiC = Get.put(CutiPageController());
  final cameraC = Get.put(CameraDataController());

  RxString imgPath = "".obs;

  String jenisCutiController = "Jenis Cuti";
  String pickDateDari = "";
  String pickDateSampaiDengan = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            GestureDetector(
              onTap: () async {
                await jenisCuti();
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: darkGreyColor),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.work_outline_outlined,
                      color: darkGreyColor,
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: Get.width * 0.6,
                      child: Text(
                        jenisCutiController,
                        maxLines: 2,
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    new Spacer(),
                    Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: darkGreyColor,
                    ),
                  ],
                ),
              ),
            ),

            const Gap(15),
            // ....

            GestureDetector(
              onTap: () async => await datePickter(true),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: darkGreyColor),
                ),
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Icon(
                      Icons.date_range_outlined,
                      color: darkGreyColor,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      (pickDateDari.isEmpty)
                          ? "Pilih tanggal"
                          : "${DateFormat("dd MMMM yyyy", "id_ID").format(DateTime.parse(pickDateDari))}",
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (pickDateDari.isNotEmpty) ...{
              const Gap(15),
              GestureDetector(
                onTap: () async => await datePickter(false),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: darkGreyColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Icon(
                        Icons.date_range_outlined,
                        color: darkGreyColor,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        (pickDateSampaiDengan.isEmpty)
                            ? "Sampai dengan"
                            : "${DateFormat("dd MMMM yyyy", "id_ID").format(DateTime.parse(pickDateSampaiDengan))}",
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            },

            //....
            const Gap(15),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(width: 1, color: darkGreyColor),
                ),
                prefixIcon: Icon(Iconsax.activity),
                hintText: "Alasan",
                hintStyle: darkGreyTextStyle,
              ),
            ),
            const Gap(15),

            GestureDetector(
              onTap: () async {
                dilegasi();
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: darkGreyColor),
                ),
                child: Row(
                  children: [
                    Icon(Iconsax.user),
                    const Gap(10),
                    SizedBox(
                      width: Get.width * 0.6,
                      child: Text(
                        "Dilegasi ke (opsional)",
                        maxLines: 2,
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    new Spacer(),
                    Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: darkGreyColor,
                    ),
                  ],
                ),
              ),
            ),
            // ....

            // ..
            const Gap(15),
            GestureDetector(
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
                          onTap: () async => imgPath(
                              (await cameraC.pickImage(ImageSource.camera))
                                  .path),
                          child: IconWidgetService(
                            Iconsax.camera,
                            "Kamera",
                            greenColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async => imgPath(
                              (await cameraC.pickImage(ImageSource.gallery))
                                  .path),
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
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: darkGreyColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Icon(
                      Icons.file_copy_outlined,
                      color: darkGreyColor,
                    ),
                    const SizedBox(width: 10),
                    Obx(
                      () => SizedBox(
                        width: Get.width * 0.7,
                        child: Text(
                          (imgPath.value.isNotEmpty)
                              ? imgPath.value.split("/").last
                              : "Input file",
                          maxLines: 2,
                          style: blackTextStyle.copyWith(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              "ukuran maksimal file 10 MB",
              style: darkGreyTextStyle,
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
                    style: blackTextStyle.copyWith(
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
                      onTap: () {
                        jenisCutiController = cutiC.tipeCuti[index];
                        Get.back();
                      },
                      title: Text("293 - Lucky Alma Aficionado Rigel"),
                      subtitle: Text("Programmer"),
                      leading: CircleAvatar(),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );

  datePickter(bool isTrue) async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );

    if (picker != null) {
      if (isTrue) {
        setState(() {
          pickDateDari = picker.toIso8601String();
        });
      } else {
        setState(() {
          pickDateSampaiDengan = picker.toIso8601String();
        });
      }
    }
  }

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
                      style: blackTextStyle.copyWith(
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
                        onTap: () {
                          jenisCutiController = cutiC.tipeCuti[index];
                          Get.back();
                        },
                        title: Text(cutiC.tipeCuti[index]),
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
      style: blackTextStyle.copyWith(
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
