import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:talenta_app/app/shared/theme.dart';

class DetailInboxView extends GetView {
  const DetailInboxView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Detail Inbox',
            style: appBarTextStyle,
          ),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: whiteColor,
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
                  CircleAvatar(radius: 25),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Maria Setiawati Purbaningtyas",
                        style: blueTextStyle.copyWith(
                          fontWeight: semiBold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Attendance Request Approved",
                        style: blackTextStyle,
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
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 230,
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(),
                                    const SizedBox(width: 15),
                                    Text(
                                      "Maria Setiawati Purbaningtyas",
                                      style: blackTextStyle.copyWith(
                                        fontWeight: semiBold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    new Spacer(),
                                    IconButton(
                                      onPressed: () => Get.back(),
                                      icon: Icon(Icons.close),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.4,
                                        child: Text("ID Karyawan"),
                                      ),
                                      Text(": "),
                                      SizedBox(
                                        width: Get.width * 0.4,
                                        child: Text("074"),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.4,
                                        child: Text("Organisasi"),
                                      ),
                                      Text(": "),
                                      SizedBox(
                                        width: Get.width * 0.4,
                                        child: Text("Personalia & Umum"),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.4,
                                        child: Text("Posisi pekerjaan"),
                                      ),
                                      Text(": "),
                                      SizedBox(
                                        width: Get.width * 0.4,
                                        child: Text("Staff Personalia"),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.4,
                                        child: Text("Cabang"),
                                      ),
                                      Text(": "),
                                      SizedBox(
                                        width: Get.width * 0.4,
                                        child: Text(
                                            "CV Andi Offset Yogyakarta Pusat"),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.account_circle_outlined),
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Your request attendance, check in on 18 Mar 2024 at 07:53 for 18 Mar 2024 has been approved. Reason: pertama kali pake berbakat",
                  style: blackTextStyle.copyWith(
                    fontWeight: extraLight,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
