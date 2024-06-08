import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:talenta_app/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:talenta_app/app/shared/textfield/textfield_1.dart';

import '../../../shared/button/button_1.dart';

class LoginView extends GetView<AuthController> {
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.topLeft,
            begin: Alignment.bottomRight,
            colors: [
              Colors.blue.shade100,
              Colors.blue.shade100,
              Colors.blue.shade100,
              Colors.white,
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: context.height * 0.1),
            Image.asset(
              "assets/images/img_logo.png",
              width: 180,
              height: 180,
            ),
            Gap(context.height * 0.05),
            const Gap(15),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Material(
                elevation: 5,
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextField1(
                        controller: controller.email,
                        hintText: "Email",
                        preffixIcon: Icon(Boxicons.bx_user),
                        textInputAction: TextInputAction.next,
                      ),
                      const Gap(10),
                      Obx(
                        () => TextField1(
                          controller: controller.password,
                          hintText: "Password",
                          obsecure: controller.obsecure.value,
                          maxLines: 1,
                          textInputAction: TextInputAction.done,
                          preffixIcon: Icon(Boxicons.bx_lock_alt),
                          suffixIcon: IconButton(
                            onPressed: () => controller.obsecure.toggle(),
                            icon: Icon(
                              (controller.obsecure.value)
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Button1(
                title: "Log In",
                onTap: () => controller.login(
                  controller.email.text,
                  controller.password.text,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
