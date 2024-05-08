import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:talenta_app/app/shared/theme.dart';

class PeringatanView extends GetView {
  const PeringatanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Peringatan',
            style: appBarTextStyle,
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            WidgetFilterService(),
            Expanded(
                child: (false)
                    ? Column(
                        children: [],
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
                      )),
          ],
        ));
  }
}

class WidgetFilterService extends StatelessWidget {
  const WidgetFilterService({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: Get.width,
      child: LayoutBuilder(
        builder: (context, constraints) => Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: darkGreyColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: constraints.maxWidth * 0.8,
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Icon(
                      Icons.date_range,
                      color: darkGreyColor,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "${DateFormat("yyyy").format(DateTime.now())}",
                      style: blackTextStyle,
                    ),
                    new Spacer(),
                    Icon(
                      Icons.arrow_drop_down,
                      color: darkGreyColor,
                    ),
                  ],
                ),
              ),
            ),
            new Spacer(),
            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: darkGreyColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(15),
                child: Icon(
                  Icons.filter_alt_outlined,
                  color: darkGreyColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
