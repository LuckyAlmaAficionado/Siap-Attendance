import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:talenta_app/app/controllers/date_controller.dart';
import 'package:talenta_app/app/controllers/file_picker_controller.dart';

import 'package:talenta_app/app/shared/theme.dart';
import 'package:talenta_app/app/shared/utils.dart';

// ignore: must_be_immutable
class PengajuanReimbursementTextfieldView extends StatefulWidget {
  @override
  State<PengajuanReimbursementTextfieldView> createState() =>
      _PengajuanReimbursementTextfieldViewState();
}

class _PengajuanReimbursementTextfieldViewState
    extends State<PengajuanReimbursementTextfieldView> {
  final dateC = Get.put(DateController());
  final fileC = Get.put(FilePickerController());

  String? path;

  TextEditingController tanggalC = TextEditingController();
  TextEditingController namaReimbursement = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  TextEditingController pathC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Ajukan Reimbursement',
            style: appBarTextStyle,
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            const Gap(30),
            ListTile(
              leading: Icon(Icons.date_range_outlined),
              title: Text(
                "Tanggal",
                style: blackTextStyle.copyWith(
                  fontWeight: regular,
                  fontSize: 14,
                ),
              ),
              subtitle: TextField(
                style: blackTextStyle,
                controller: tanggalC,
              ),
              trailing: IconButton(
                onPressed: () async {
                  DateTime? picker = await dateC.pickerDateTime(context);
                  setState(() {
                    tanggalC.text =
                        DateFormat('dd MMM yyyy', "id_ID").format(picker);
                  });
                },
                icon: Icon(Icons.keyboard_arrow_down_sharp),
              ),
            ),
            ListTile(
              leading: Icon(Icons.attach_money_sharp),
              title: Text(
                "Nama Reimbursement",
                style: blackTextStyle.copyWith(
                  fontWeight: regular,
                  fontSize: 14,
                ),
              ),
              subtitle: TextField(
                style: blackTextStyle,
                controller: namaReimbursement,
              ),
              trailing: IconButton(
                onPressed: () async {
                  DateTime? picker = await dateC.pickerDateTime(context);
                  setState(() {
                    tanggalC.text =
                        DateFormat('dd MMM yyyy', "id_ID").format(picker);
                  });
                },
                icon: Icon(Icons.keyboard_arrow_down_sharp),
              ),
            ),
            ListTile(
              leading: Icon(Icons.format_align_left_sharp),
              title: Text(
                "Deskripsi",
                style: blackTextStyle.copyWith(
                  fontWeight: regular,
                  fontSize: 14,
                ),
              ),
              subtitle: TextField(
                style: blackTextStyle,
                controller: descriptionC,
              ),
            ),
            ListTile(
              leading: Icon(Icons.upload_file_outlined),
              title: Text(
                "Unggah File",
                style: blackTextStyle.copyWith(
                  fontWeight: regular,
                  fontSize: 14,
                ),
              ),
              subtitle: TextField(
                style: blackTextStyle,
                decoration: InputDecoration(
                  hintText: "Ukuran maksimal file 10mb",
                  hintStyle: darkGreyTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: extraLight,
                  ),
                ),
                readOnly: true,
                maxLines: 2,
                controller: pathC,
              ),
              trailing: IconButton(
                  onPressed: () async {
                    path = await fileC.openFileExplorerPDF();
                    setState(() {
                      pathC.text = path!.split("/").last;
                    });
                  },
                  icon: Icon(Icons.add_box_outlined)),
            ),
            const Gap(80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                title: "Ajukan",
                onTap: () {},
              ),
            ),
          ],
        ));
  }
}
