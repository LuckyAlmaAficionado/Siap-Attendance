import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:talenta_app/app/shared/theme.dart';

class InfoKeluargaViewView extends GetView {
  const InfoKeluargaViewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Info keluarga",
                style: blackTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  "Data info keluarga kosong",
                  style: darkGreyTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: extraLight,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
