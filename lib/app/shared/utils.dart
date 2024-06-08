import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:talenta_app/app/controllers/api_controller.dart';

import 'package:talenta_app/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:talenta_app/app/modules/authentication/views/login_view.dart';
import 'package:talenta_app/app/shared/button/button_1.dart';
import 'package:talenta_app/app/shared/theme.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.title,
    this.onTap,
  });

  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: Get.width,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          title,
          style: normalTextStyle.copyWith(
            fontWeight: medium,
            color: whiteColor,
            fontSize: 14,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: blueColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}

class Utils {
  informationUtils(String title, String subTitle, bool showButton) =>
      Get.dialog(
        barrierColor: Colors.grey.withOpacity(0.6),
        barrierDismissible: true,
        Center(
          child: Container(
            width: Get.width * 0.8,
            height: Get.height * 0.5,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/icons/ic_information.png',
                  ),
                ),
                const Gap(10),
                DefaultTextStyle(
                  style: normalTextStyle.copyWith(
                    fontWeight: black,
                    color: blueColor,
                    fontSize: 22,
                  ),
                  child: Text("$title"),
                ),
                const Gap(10),
                DefaultTextStyle(
                  style: normalTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                  child: Text("$subTitle"),
                ),
                const Gap(35),
                if (showButton)
                  Button1(
                    title: "Back to Home",
                    onTap: () => Get.back(),
                  ),
              ],
            ),
          ),
        ),
      );

  snackbarC(title, message, isTrue) => Get.showSnackbar(
        GetSnackBar(
          backgroundColor: (isTrue) ? Colors.green.shade50 : Colors.red.shade50,
          duration: const Duration(seconds: 1),
          title: "PIN Salah",
          message: "Masukan PIN lagi",
          titleText: Text(
            title,
            style: (isTrue)
                ? greenTextStyle.copyWith(fontWeight: semiBold)
                : redTextStyle.copyWith(fontWeight: semiBold),
          ),
          messageText: Text(
            message,
            style: (isTrue)
                ? greenTextStyle.copyWith(fontWeight: extraLight)
                : redTextStyle.copyWith(fontWeight: extraLight),
          ),
        ),
      );

  feedbackApps(BuildContext context) => showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        builder: (context) {
          return Container(
            height: 220,
            padding: const EdgeInsets.all(20),
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.close,
                    color: darkGreyColor,
                  ),
                ),
                Text(
                  "Bagaimana pengalaman Anda\nmenggunakan aplikasi Berbakat?",
                  style: blackTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: List.generate(
                    5,
                    (index) => Expanded(
                      child: Icon(
                        Icons.emoji_emotions_outlined,
                        size: 50,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      );

  exitRequestDialog() => Get.dialog(
        Center(
          child: Container(
            width: Get.width * 0.6,
            height: Get.width * 0.50,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: darkBlueColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: DefaultTextStyle(
                      style: whiteTextStyle,
                      child: Text(
                        "Keluar dari Berbakat?",
                        style: whiteTextStyle.copyWith(
                          fontWeight: semiBold,
                          fontSize: 14,
                        ),
                      )),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DefaultTextStyle(
                      style: blackTextStyle,
                      child: Text(
                        "Anda perlu login ulang untuk kembali.",
                        textAlign: TextAlign.center,
                      )),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: whiteColor,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: darkGreyColor,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "Batal",
                        style: blackTextStyle,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        await Get.find<AuthController>()
                            .hiveRemoveEmailAndPassword()
                            .then((_) => Get.off(() => LoginView()));
                      },
                      child: Text(
                        "Keluar",
                        style: whiteTextStyle,
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

class AlertExit extends StatelessWidget {
  const AlertExit({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      contentPadding: const EdgeInsets.all(0),
      content: Container(
        width: context.width * 0.6,
        height: context.width * 0.4,
        child: LayoutBuilder(
          builder: (context, constraints) => Column(
            children: [
              Container(
                height: constraints.maxHeight * 0.3,
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  color: blueColor,
                ),
                alignment: Alignment.center,
                child: Text(
                  "Keluar dari SIAP?",
                  style: normalTextStyle.copyWith(
                    fontSize: 16,
                    color: whiteColor,
                    fontWeight: semiBold,
                  ),
                ),
              ),
              Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight * 0.7,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Anda perlu login lagi setelah keluar!",
                      style: normalTextStyle,
                    ),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                          width: constraints.maxWidth * 0.4,
                          child: Button1(
                            color: blueColor,
                            title: "Kembali",
                            onTap: () => Get.back(),
                          ),
                        ),
                        const Gap(20),
                        SizedBox(
                          height: 40,
                          width: constraints.maxWidth * 0.4,
                          child: Button1(
                            color: redColor,
                            title: "Keluar",
                            onTap: () => Get.put(ApiController()).logOut(),
                            // onTap: () => Get.put(AuthController())
                            //     .hiveRemoveEmailAndPassword()
                            //     .then((value) => Get.offAll(() => LoginView())),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
