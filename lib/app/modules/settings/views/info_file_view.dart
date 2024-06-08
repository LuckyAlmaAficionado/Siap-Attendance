import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:talenta_app/app/shared/button/button_1.dart';
import 'package:talenta_app/app/shared/textfield/textfield_1.dart';
import 'package:talenta_app/app/shared/theme.dart';

class InfoFileView extends GetView {
  const InfoFileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: IconThemeData(color: blackColor),
        title: Text(
          'File Saya',
          style: appBarTextStyle.copyWith(
            color: blackColor,
          ),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: TextField1(
              hintText: "Cari....",
              preffixIcon: HeroIcon(HeroIcons.magnifyingGlass),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            right: 15,
            left: 15,
            bottom: 15,
            child: Button1(
              title: "Unggah File",
              onTap: () {},
            ),
          ),
          Container(
            width: context.width,
            height: context.height,
            child: ListView(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
