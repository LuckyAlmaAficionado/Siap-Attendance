import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:talenta_app/app/controllers/authentication_controller.dart';
import 'package:talenta_app/app/modules/dashboard_page/views/dashboard_page_view.dart';
import 'package:talenta_app/app/modules/validator_pin/views/validator_pin_view.dart';
import 'package:talenta_app/app/shared/splash.dart';
import 'package:talenta_app/app/shared/theme.dart';
import 'package:talenta_app/app/shared/utils.dart';

import '../controllers/sign_in_page_controller.dart';

class SignInPageView extends GetView<SignInPageController> {
  SignInPageView({Key? key}) : super(key: key);

  final controller = Get.put(SignInPageController());
  final authC = Get.put(AuthenticationController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // cek apakah auto login atau tidak
      future: authC.autoLoginIsTrue(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Jika loading ...
          return SplashPageView();
        } else if (snapshot.hasData) {
          bool result = snapshot.data as bool;

          if (result) {
            // Jika login
            return FutureBuilder(
              future: authC.validatorPIN(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  bool result = snapshot.data as bool;

                  if (result) {
                    // Jika menggunakan pin
                    return ValidatorPinView();
                  } else {
                    // Jika tidak menggunakan pin
                    return DashboardPageView();
                  }
                }

                // Jika loading
                return SplashPageView();
              },
            );
          } else {
            // Jika tidak login
            return SignInView();
          }
        }

        return Scaffold(
          body: Container(child: Center(child: Text("Something Error"))),
        );
      },
    );
  }
}

class SignInView extends StatelessWidget {
  SignInView({super.key});

  final controller = Get.put(SignInPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign In",
                style: blackTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 18,
                ),
              ),
              const Gap(3),
              Text(
                "Selamat datang kembali di Andi Intelegent",
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: regular,
                ),
              ),
              const Gap(20),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Text(
                  "Email",
                  style: darkGreyTextStyle.copyWith(
                    fontWeight: regular,
                    fontSize: 14,
                  ),
                ),
                subtitle: TextField(
                  controller: controller.emailC,
                  style: blackTextStyle,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: blackColor,
                    ),
                    border: UnderlineInputBorder(),
                    hintText: "Email",
                    hintStyle: darkGreyTextStyle.copyWith(
                      fontWeight: regular,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const Gap(15),
              Obx(
                () => ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(
                    "Password",
                    style: darkGreyTextStyle.copyWith(
                      fontWeight: regular,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: TextField(
                    controller: controller.passwordC,
                    style: blackTextStyle,
                    obscureText: controller.isObsecure.value,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        color: blackColor,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () => controller.isObsecure.toggle(),
                        icon: (controller.isObsecure.value)
                            ? Icon(Icons.visibility_outlined)
                            : Icon(Icons.visibility_off_outlined),
                      ),
                      border: UnderlineInputBorder(),
                      hintText: "Password",
                      hintStyle: darkGreyTextStyle.copyWith(
                        fontWeight: regular,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Lupa Password?",
                      style: blueTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: semiBold,
                      ),
                    )),
              ),
              const SizedBox(height: 30),
              if (true)
                CustomButton(
                  title: 'Sign In',
                  onTap: () {
                    Utils().informationUtils(
                      "Loading..!",
                      "Sebentar yaa",
                      false,
                    );

                    controller.login();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
