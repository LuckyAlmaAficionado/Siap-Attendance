import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';

import 'package:talenta_app/app/controllers/model_controller.dart';
import 'package:talenta_app/app/shared/images/images.dart';
import 'package:talenta_app/app/shared/theme.dart';

import '../controllers/slip_gaji_page_controller.dart';

class SlipGajiPageView extends GetView<SlipGajiPageController> {
  SlipGajiPageView({Key? key}) : super(key: key);

  final m = Get.find<ModelController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Slip Gaji",
            style: appBarTextStyle.copyWith(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: blackColor),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(230),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: Get.width,
                    height: 50,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Pilih periode",
                          style: blackTextStyle.copyWith(
                            fontWeight: regular,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {},
                          icon: Icon(Icons.keyboard_arrow_down_sharp),
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  Container(
                      width: Get.width,
                      height: 140,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "*RAHASIA",
                            style: redTextStyle.copyWith(
                              fontWeight: semiBold,
                              fontSize: 14,
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            color: darkGreyColor,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Lucky Alma Aficionado Rigel",
                                    style: blackTextStyle.copyWith(
                                      fontWeight: semiBold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "Programmer",
                                    style: blackTextStyle.copyWith(
                                      fontWeight: extraLight,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              new Spacer(),
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: ImageNetwork(
                                  url: m.u.value!.avatar!,
                                ),
                              )
                            ],
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
        body: FutureBuilder(
          future: controller.checkUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return (false)
                  ? ListView()
                  : SizedBox(
                      width: Get.width,
                      height: Get.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          HeroIcon(
                            HeroIcons.banknotes,
                            size: 60,
                          ),
                          const Gap(5),
                          Text(
                            "Coba buka ini nanti",
                            style: normalTextStyle.copyWith(
                              fontWeight: extraBold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "Slip gaji ini masuh dikunci oleh Admin kantor Anda",
                            style: normalTextStyle.copyWith(
                              fontWeight: regular,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
            }
            return Container();
          },
        ));
  }
}
