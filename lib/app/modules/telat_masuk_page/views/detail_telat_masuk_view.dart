import 'package:flutter/material.dart';

import 'package:another_stepper/another_stepper.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:talenta_app/app/controllers/model_controller.dart';
import 'package:talenta_app/app/models/approval.dart';
import 'package:talenta_app/app/shared/theme.dart';

class DetailTelatMasukView extends StatefulWidget {
  const DetailTelatMasukView({Key? key}) : super(key: key);

  @override
  State<DetailTelatMasukView> createState() => _DetailTelatMasukViewState();
}

class _DetailTelatMasukViewState extends State<DetailTelatMasukView> {
  final m = Get.find<ModelController>();

  @override
  void initState() {
    super.initState();
    approval = Get.arguments as Approval;
    approval.approvals
        .sort((a, b) => a.approverOrder.compareTo(b.approverOrder));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 35,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        width: 1,
                        color: whiteColor,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        "${m.u.value!.avatar}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Text(
                  '${m.u.value!.nama}',
                  style: whiteTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "${m.u.value!.jabatan}",
                  style: whiteTextStyle,
                ),
                const Gap(20),
              ],
            )),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: LayoutBuilder(
          builder: (context, constraints) => ListView(
            children: [
              const Gap(20),
              Text(
                "Detail Pengajuan",
                style: normalTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 16,
                ),
              ),
              const Gap(20),
              Row(
                children: [
                  SizedBox(
                      width: constraints.maxWidth * 0.5,
                      child: Text(style: normalTextStyle, "Tanggal Cuti")),
                  SizedBox(
                      width: constraints.maxWidth * 0.5,
                      child: Text(style: normalTextStyle, "02 Apr 2024"))
                ],
              ),
              const Gap(10),
              Row(
                children: [
                  SizedBox(
                      width: constraints.maxWidth * 0.5,
                      child: Text(style: normalTextStyle, "Jenis Izin")),
                  SizedBox(
                      width: constraints.maxWidth * 0.5,
                      child: Text(style: normalTextStyle, "Masuk Terlambat"))
                ],
              ),
              const Gap(20),
              Text(
                "Status Pengajuan",
                style: normalTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 16,
                ),
              ),
              AnotherStepper(
                stepperList:
                    List.generate(approval.approvals.length + 1, (index) {
                  print(approval.approvals.length);

                  return StepperData(
                    title: StepperText(
                        (index == 0)
                            ? "Pengajuan di ajukan untuk Masuk Terlambat"
                            : "${approval.approvals[index - 1].approved ? "Disetujui" : "Menunggu"} disetujui oleh ${approval.approvals[index - 1].approver}",
                        textStyle: normalTextStyle),
                    subtitle: StepperText("02 Apr 2024 10:19",
                        textStyle: normalTextStyle),
                  );
                }),
                activeIndex:
                    approval.approvals.where((e) => e.approved == true).length,
                stepperDirection: Axis.vertical,
                inverted: false,
              )
            ],
          ),
        ),
      ),
    );
  }

  late Approval approval;
}
