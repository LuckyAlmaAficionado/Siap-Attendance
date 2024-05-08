import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:talenta_app/app/shared/theme.dart';
import 'package:talenta_app/app/shared/utils.dart';

class FileSayaView extends GetView {
  const FileSayaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File saya', style: appBarTextStyle),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (true)
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(Icons.picture_as_pdf_outlined),
                            title: Text(
                              "Company File",
                              style: blackTextStyle.copyWith(
                                fontWeight: regular,
                              ),
                            ),
                            subtitle: Text(
                              "Perjanjian Kerja Bersama 2022",
                              style: darkGreyTextStyle.copyWith(
                                fontWeight: extraLight,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          width: 300,
                          height: 300,
                          child: Image.asset("assets/images/img_shift.png"),
                        ),
                        Text(
                          "Tidak ada peringatan",
                          style: blackTextStyle.copyWith(
                            fontWeight: semiBold,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            "Saat Anda mendapatkan peringatan, itu akan muncul di sini",
                            textAlign: TextAlign.center,
                            style: darkGreyTextStyle.copyWith(
                              fontWeight: regular,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    )
            ],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: CustomButton(
              title: "Unggah File",
            ),
          )
        ],
      ),
    );
  }
}
