import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:talenta_app/app/shared/theme.dart';

import '../controllers/slip_gaji_page_controller.dart';

class SlipGajiPageView extends GetView<SlipGajiPageController> {
  const SlipGajiPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Slip Gaji",
            style: appBarTextStyle,
          ),
          centerTitle: true,
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
                      color: whiteColor,
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
                        color: whiteColor,
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
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: lightGreyColor,
                                child: controller.data.user.avatar!.isEmpty
                                    ? Icon(Iconsax.user)
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                          loadingBuilder: (context, child,
                                                  loadingProgress) =>
                                              loadingProgress == null
                                                  ? child
                                                  : CircularProgressIndicator(),
                                          "${controller.data.user.avatar}",
                                        ),
                                      ),
                              ),
                            ],
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
        body: (false)
            ? ListView()
            : SizedBox(
                width: Get.width,
                height: Get.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.wallet,
                      size: 100,
                    ),
                    const Gap(20),
                    Text(
                      "Coba buka ini nanti",
                      style: blackTextStyle.copyWith(
                        fontWeight: extraBold,
                        fontSize: 20,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      "Slip gaji ini masuh dikunci oleh Admin kantor Anda",
                      style: blackTextStyle.copyWith(
                        fontWeight: regular,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ));
  }
}
