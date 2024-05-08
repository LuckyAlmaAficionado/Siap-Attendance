import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:talenta_app/app/shared/theme.dart';

class DetailPersetujuanPageView extends GetView {
  const DetailPersetujuanPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Persetujuan',
          style: appBarTextStyle,
        ),
        centerTitle: true,
      ),
      body: Container(
        width: Get.width,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(),
                // ... information
                const Gap(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fachrun Wire Prana",
                      style: redTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "Time Off Request",
                      style: blackTextStyle.copyWith(
                        fontWeight: regular,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "01 Apr 2024 12:06",
                      style: blackTextStyle.copyWith(
                        fontWeight: regular,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                new Spacer(),
                // ... Icon Button
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: const EdgeInsets.all(15),
                          width: Get.width,
                          height: 230,
                          child: Column(
                            children: [
                              // bio pengguna
                              Row(
                                children: [
                                  CircleAvatar(),
                                  const Gap(15),
                                  Text(
                                    "Fachrun Wire Prana",
                                    style: blackTextStyle.copyWith(
                                      fontWeight: regular,
                                      fontSize: 16,
                                    ),
                                  ),
                                  new Spacer(),
                                  IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: Icon(Icons.close),
                                  ),
                                ],
                              ),
                              const Gap(10),
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: constraints.maxWidth * 0.5,
                                            child: Text(
                                              "Employee ID",
                                              style: redTextStyle,
                                            ),
                                          ),
                                          SizedBox(
                                            width: constraints.maxWidth * 0.5,
                                            child: Text(
                                              ": 3022",
                                              style: blackTextStyle,
                                            ),
                                          )
                                        ],
                                      ),
                                      const Gap(10),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: constraints.maxWidth * 0.5,
                                            child: Text(
                                              "Organization",
                                              style: redTextStyle,
                                            ),
                                          ),
                                          SizedBox(
                                            width: constraints.maxWidth * 0.5,
                                            child: Text(
                                              ": AGS",
                                              style: blackTextStyle,
                                            ),
                                          )
                                        ],
                                      ),
                                      const Gap(10),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: constraints.maxWidth * 0.5,
                                            child: Text(
                                              "Job Position",
                                              style: redTextStyle,
                                            ),
                                          ),
                                          SizedBox(
                                            width: constraints.maxWidth * 0.5,
                                            child: Text(
                                              ": Programmer",
                                              style: blackTextStyle,
                                            ),
                                          )
                                        ],
                                      ),
                                      const Gap(10),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: constraints.maxWidth * 0.5,
                                            child: Text(
                                              "Branch",
                                              style: redTextStyle,
                                            ),
                                          ),
                                          SizedBox(
                                            width: constraints.maxWidth * 0.5,
                                            child: Text(
                                              ": CV Andi Offset Yogyakarta Pusat",
                                              style: blackTextStyle,
                                            ),
                                          )
                                        ],
                                      ),
                                      const Gap(10),
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.account_circle_outlined),
                ),
              ],
            ),
            const Gap(20),
            Text(
              "Fachrun Wire Prana would like to request time off for this date:",
              style: blackTextStyle.copyWith(
                fontSize: 14,
              ),
            ),
            const Gap(10),
            Text(
              "Mon, 15 Apr 2024 until Wed, 17 Apr 2024",
              style:
                  blackTextStyle.copyWith(fontWeight: extraBold, fontSize: 14),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: Get.width,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: constraints.maxWidth * 0.5,
                            child: Text(
                              "Time off type",
                              style: redTextStyle,
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth * 0.5,
                            child: Text(
                              "Time off type",
                              style: blackTextStyle,
                            ),
                          )
                        ],
                      ),
                      const Gap(15),
                      Row(
                        children: [
                          SizedBox(
                            width: constraints.maxWidth * 0.5,
                            child: Text(
                              "Request type",
                              style: redTextStyle,
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth * 0.5,
                            child: Text(
                              "Full day",
                              style: blackTextStyle,
                            ),
                          )
                        ],
                      ),
                      const Gap(15),
                      Row(
                        children: [
                          SizedBox(
                            width: constraints.maxWidth * 0.5,
                            child: Text(
                              "Requesting",
                              style: redTextStyle,
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth * 0.5,
                            child: Text(
                              "3 days",
                              style: blackTextStyle,
                            ),
                          )
                        ],
                      ),
                      const Gap(15),
                      Row(
                        children: [
                          SizedBox(
                            width: constraints.maxWidth * 0.5,
                            child: Text(
                              "Remaining balance",
                              style: redTextStyle,
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth * 0.5,
                            child: Text(
                              "8 days",
                              style: blackTextStyle,
                            ),
                          )
                        ],
                      ),
                      const Gap(15),
                      Row(
                        children: [
                          SizedBox(
                            width: constraints.maxWidth * 0.5,
                            child: Text(
                              "Reason",
                              style: redTextStyle,
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth * 0.5,
                            child: Text(
                              "Pulang Kampung",
                              style: blackTextStyle,
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Material(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -0.1),
                color: darkGreyColor.withAlpha(100),
                spreadRadius: 2,
                blurRadius: 3,
              )
            ],
          ),
          width: Get.width,
          height: 200,
          child: Column(
            children: [
              const Gap(10),
              SizedBox(
                width: Get.width,
                height: 120,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      width: 1,
                      color: lightGreyColor,
                    )),
                    hintText: "Type your comment here...",
                    hintStyle: darkGreyTextStyle.copyWith(
                      fontWeight: extraLight,
                      fontSize: 14,
                    ),
                  ),
                  maxLines: 3,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: whiteColor,
                        ),
                        onPressed: () {},
                        child: Text(
                          "Reject",
                          style: redTextStyle.copyWith(
                            fontWeight: regular,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(20),
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Approve",
                          style: whiteTextStyle.copyWith(
                            fontWeight: regular,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
