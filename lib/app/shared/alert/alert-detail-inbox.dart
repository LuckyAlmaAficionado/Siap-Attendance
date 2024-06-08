import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:talenta_app/app/shared/images/images.dart';
import 'package:talenta_app/app/shared/theme.dart';

class DetailInboxView extends GetView {
  const DetailInboxView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          elevation: 0.4,
          title: Text(
            'Detail Inbox',
            style: appBarTextStyle.copyWith(color: Colors.black),
          ),
          centerTitle: false,
          titleSpacing: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: blackColor,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              // detail info contact
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: ImageNetwork(url: "url"),
                  ),
                  const SizedBox(width: 15),
                  SizedBox(
                    width: context.width * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Maria Setiawati Purbaningtyas",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: blueTextStyle.copyWith(
                            fontWeight: semiBold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Attendance Request Approved",
                          style: normalTextStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '${DateFormat("dd MMM yyyy   hh:MM", "id_ID").format(DateTime.now())}',
                          style: darkGreyTextStyle.copyWith(
                            fontWeight: extraLight,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () => detailInformations(),
                    icon: Icon(Boxicons.bx_info_circle),
                  )
                ],
              ),
              const Gap(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  "Your request attendance, check in on 18 Mar 2024 at 07:53 for 18 Mar 2024 has been approved. Reason: pertama kali pake berbakat",
                  style: normalTextStyle.copyWith(
                    fontWeight: extraLight,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  detailInformations() => Get.bottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        backgroundColor: whiteColor,
        Container(
          height: 250,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: ImageNetwork(url: "###"),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Maria Setiawati Purbaningtyas",
                    style: normalTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 14,
                    ),
                  ),
                  new Spacer(),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              const Gap(10),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: Get.width * 0.4,
                      child: Text(style: normalTextStyle, "ID Karyawan"),
                    ),
                    Text(style: normalTextStyle, ": "),
                    SizedBox(
                      width: Get.width * 0.4,
                      child: Text(style: normalTextStyle, "074"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: Get.width * 0.4,
                      child: Text(style: normalTextStyle, "Organisasi"),
                    ),
                    Text(style: normalTextStyle, ": "),
                    SizedBox(
                      width: Get.width * 0.4,
                      child: Text(style: normalTextStyle, "Personalia & Umum"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: Get.width * 0.4,
                      child: Text(style: normalTextStyle, "Posisi pekerjaan"),
                    ),
                    Text(style: normalTextStyle, ": "),
                    SizedBox(
                      width: Get.width * 0.4,
                      child: Text(style: normalTextStyle, "Staff Personalia"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: Get.width * 0.4,
                      child: Text(style: normalTextStyle, "Cabang"),
                    ),
                    Text(style: normalTextStyle, ": "),
                    SizedBox(
                      width: Get.width * 0.4,
                      child: Text(
                          style: normalTextStyle,
                          "CV Andi Offset Yogyakarta Pusat"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
