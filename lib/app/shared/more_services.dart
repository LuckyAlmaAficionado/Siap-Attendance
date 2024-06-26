import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:talenta_app/app/modules/daftar_absensi_page/views/pengajuan_absensi_view.dart';
import 'package:talenta_app/app/routes/app_pages.dart';

import 'package:talenta_app/app/shared/theme.dart';

class MoreServices extends StatelessWidget {
  const MoreServices({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Container(
        width: Get.width * 0.8,
        height: Get.width * 0.8,
        color: Colors.white,
        child: LayoutBuilder(
          builder: (context, constraints) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Cbutton(
                () => Get.toNamed(Routes.CUTI_PAGE),
                "Cuti",
                Icons.developer_board,
                constraints.maxHeight,
              ),
              _Cbutton(
                () => Get.toNamed(Routes.TELAT_MASUK_PAGE),
                "Istirahat Terlambat",
                Icons.developer_board,
                constraints.maxHeight,
              ),
              _Cbutton(
                () => Get.to(
                  PengajuanAbsensiView(),
                  transition: Transition.cupertino,
                ),
                "Absensi",
                Icons.location_on_sharp,
                constraints.maxHeight,
              ),
              _Cbutton(
                () => null,
                "Perubahan Shift",
                Icons.developer_board,
                constraints.maxHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _Cbutton(Function()? onTap, String title, IconData icons, double height) =>
      Container(
        height: height * 0.19,
        margin: const EdgeInsets.only(top: 10),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            onTap: onTap,
            title: Text(
              title,
              style: normalTextStyle.copyWith(
                fontSize: 14,
                fontWeight: regular,
              ),
            ),
            minLeadingWidth: 0,
            leading: Icon(icons, color: Colors.black),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        ),
      );
}
