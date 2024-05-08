import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:talenta_app/app/controllers/authentication_controller.dart';
import 'package:talenta_app/app/shared/theme.dart';
import 'package:another_stepper/another_stepper.dart';

// ignore: must_be_immutable
class StatusPersetujuanView extends GetView {
  StatusPersetujuanView({Key? key}) : super(key: key);

  final authC = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 35,
                ),
                const Gap(10),
                Text(
                  'Lucky Alma Aficionado Rigel',
                  style: whiteTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "${authC.jabatan.value}",
                  style: whiteTextStyle,
                ),
                const Gap(20),
              ],
            )),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) => Column(
            children: [
              Text(
                "Detail Pengajuan",
                style: blackTextStyle.copyWith(
                  fontWeight: regular,
                  fontSize: 16,
                ),
              ),
              const Gap(20),
              Row(
                children: [
                  SizedBox(
                      width: constraints.maxWidth * 0.5,
                      child: Text("Tanggal Cuti")),
                  SizedBox(
                      width: constraints.maxWidth * 0.5,
                      child: Text("02 Apr 2024"))
                ],
              ),
              const Gap(10),
              Row(
                children: [
                  SizedBox(
                      width: constraints.maxWidth * 0.5,
                      child: Text("Jenis Cuti")),
                  SizedBox(
                      width: constraints.maxWidth * 0.5, child: Text("izin"))
                ],
              ),
              const Gap(10),
              Row(
                children: [
                  SizedBox(
                      width: constraints.maxWidth * 0.5,
                      child: Text("Tipe Pengajuan")),
                  SizedBox(
                      width: constraints.maxWidth * 0.5,
                      child: Text("Satu hari"))
                ],
              ),
              const Gap(10),
              Row(
                children: [
                  SizedBox(
                      width: constraints.maxWidth * 0.5, child: Text("Alasan")),
                  SizedBox(
                      width: constraints.maxWidth * 0.5,
                      child: Text("Pulang kampung"))
                ],
              ),
              const Gap(20),
              Text(
                "Status Pengajuan",
                style: blackTextStyle.copyWith(
                  fontWeight: regular,
                  fontSize: 16,
                ),
              ),
              AnotherStepper(
                stepperList: stepperData,
                activeIndex: 0,
                stepperDirection: Axis.vertical,
                inverted: false,
              )
            ],
          ),
        ),
      ),
    );
  }

  List<StepperData> stepperData = [
    StepperData(
      title: StepperText("Cuti diajukan", textStyle: blackTextStyle),
      subtitle: StepperText("02 Apr 2024 10:19", textStyle: darkGreyTextStyle),
    ),
    StepperData(
      title: StepperText("Menunggu disetujui oleh Ivan Fernandin Darmawan",
          textStyle: blackTextStyle),
      subtitle: StepperText("Acara keluarga\n02 Apr 2024 10:19",
          textStyle: darkGreyTextStyle),
    ),
    StepperData(
      title: StepperText(
          "Menunggu disetujui oleh Maria Setiawati Purbaningtyas",
          textStyle: blackTextStyle),
      subtitle: StepperText("Acara keluarga\n02 Apr 2024 10:19",
          textStyle: darkGreyTextStyle),
    ),
  ];
}
