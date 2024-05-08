import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:talenta_app/app/shared/theme.dart';
import 'package:talenta_app/app/shared/utils.dart';

// ignore: must_be_immutable
class TambahKontakDaruratViewView extends GetView {
  TambahKontakDaruratViewView({Key? key}) : super(key: key);

  List<String> keluarga = [
    "Ayah",
    "Ibu",
    "Saudara Kandung",
    "Pasangan",
    "Anak",
    "Sepupu",
    "Keponakan",
    "Mertua",
    "Ipar laki-laki",
    "Sister In Law",
    "Paman",
    "Bibi",
    "Kakek",
    "Nenek",
    "Teman",
    "Rekan Kerja",
    "Lain-Lain"
  ];

  RxString hubungan = "".obs;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Tambah kontak darurat',
            style: blackTextStyle,
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: blackColor),
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.person_outline),
                  title: TextField(
                    style: blackTextStyle,
                    decoration: InputDecoration(
                      hintText: "Nama",
                      hintStyle: darkGreyTextStyle,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () async {
                    await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => Container(
                        width: Get.width,
                        height: Get.height * 0.9,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Hubungan",
                                    style: blackTextStyle.copyWith(
                                      fontWeight: semiBold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  new Spacer(),
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: Text("Tutup"),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView(
                                children: keluarga
                                    .map(
                                      (e) => ListTile(
                                        onTap: () {
                                          textEditingController.text =
                                              e.toString();
                                          Get.back();
                                        },
                                        title: Text(
                                          e.toString(),
                                          style: blackTextStyle,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  trailing: Icon(Icons.keyboard_arrow_down_outlined),
                  leading: Icon(Icons.account_circle_outlined),
                  title: TextField(
                    readOnly: true,
                    style: blackTextStyle,
                    controller: textEditingController,
                    decoration: InputDecoration(
                      hintText: "Hubungan",
                      hintStyle: darkGreyTextStyle,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    print("Hubungan keluarga");
                  },
                  leading: Icon(Icons.call_outlined),
                  title: TextField(
                    style: blackTextStyle,
                    decoration: InputDecoration(
                      hintText: "Nomor telepon",
                      hintStyle: darkGreyTextStyle,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    CustomButton(
                      title: "Tambah",
                      onTap: () {},
                    ),
                    SizedBox(
                      width: Get.width,
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          "Batalkan",
                          style: darkGreyTextStyle,
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ));
  }
}
