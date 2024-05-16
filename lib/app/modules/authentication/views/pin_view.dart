import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:talenta_app/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:talenta_app/app/shared/loading/loading1.dart';
import 'package:talenta_app/app/shared/theme.dart';

class PinView extends GetView<AuthController> {
  const PinView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<AuthController>(() => AuthController());
    RxString status = "${Get.arguments}".obs;

    print(controller.tempPin.value);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
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
        child: Container(
          height: context.height,
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() => Text(
                      (status.value == "remove-pin-code")
                          ? "Masukan PIN Untuk Di Nonaktifkan"
                          : (status.value == "set-password")
                              ? (controller.tempPin.value.isNotEmpty)
                                  ? "Masukan Kembali Pin Baru"
                                  : "Masukan PIN Baru"
                              : "Masukan PIN Anda",
                      style: normalTextStyle.copyWith(
                        color: Colors.blue[900],
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    )),
                const SizedBox(height: 30),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      6,
                      (index) => AnimatedContainer(
                        curve: Curves.easeInCubic,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        duration: const Duration(milliseconds: 100),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (controller.textfield.value.length < index + 1)
                              ? Colors.blue[100]
                              : Colors.blue[500],
                        ),
                        width: (controller.textfield.value.length < index + 1)
                            ? 5
                            : 15,
                        height: (controller.textfield.value.length < index + 1)
                            ? 5
                            : 15,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(30),
                  margin: EdgeInsets.only(top: context.height * 0.06),
                  height: context.height * 0.6,
                  width: context.width,
                  child: LayoutBuilder(
                    builder: (context, constraints) => Column(
                      children: [
                        CustomNumberButton(
                          controller: controller,
                          constraints: constraints,
                          startIndex: 1,
                        ),
                        CustomNumberButton(
                          controller: controller,
                          constraints: constraints,
                          startIndex: 4,
                        ),
                        CustomNumberButton(
                          controller: controller,
                          constraints: constraints,
                          startIndex: 7,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 50,
                              child: Icon(
                                size: 50,
                                color: Colors.white,
                                Icons.fingerprint,
                              ),
                            ),
                            Container(
                              height: constraints.maxHeight / 4,
                              alignment: Alignment.center,
                              child: Material(
                                elevation: 2,
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(100),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(100),
                                  highlightColor: Colors.blue[900],
                                  onTapCancel: () => controller.onClicked(-1),
                                  onTapDown: (details) =>
                                      controller.onClicked(10),
                                  onTapUp: (_) => controller.onClicked(-1),
                                  onTap: () {
                                    if (controller.textfield.value.length < 6) {
                                      _checkLenghtPin(0);
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: constraints.maxWidth * 0.26,
                                    height: constraints.maxWidth * 0.26,
                                    child: Obx(
                                      () => Text(
                                        "0",
                                        style: normalTextStyle.copyWith(
                                          fontSize: 25,
                                          color:
                                              (controller.onClicked.value == 10)
                                                  ? Colors.white
                                                  : Colors.blue[900],
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                                width: 50,
                                child: IconButton(
                                  onPressed: () {
                                    if (controller.textfield.value.length > 0) {
                                      String originalString =
                                          controller.textfield.value;
                                      String newString =
                                          originalString.substring(
                                              0, originalString.length - 1);
                                      controller.textfield(newString);
                                      print(controller.textfield.value);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.backspace_outlined,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Material(
                    elevation: 2,
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(100),
                    child: InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        Get.bottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          backgroundColor: Colors.white,
                          Container(
                            width: context.width,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            height: context.height * 0.25,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  title: RichText(
                                    text: TextSpan(
                                        text: 'Password',
                                        style: normalTextStyle.copyWith(
                                          color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "*",
                                            style: TextStyle(color: Colors.red),
                                          )
                                        ]),
                                  ),
                                  subtitle: Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    child: Obx(
                                      () => TextField(
                                        obscureText: controller.obsecure.value,
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            onPressed: () =>
                                                controller.obsecure.toggle(),
                                            icon: Icon(
                                              (controller.obsecure.value)
                                                  ? Icons
                                                      .visibility_off_outlined
                                                  : Icons.visibility_outlined,
                                              color: (controller.obsecure.value)
                                                  ? Colors.blue[500]
                                                  : Colors.blue[500],
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  height: 55,
                                  width: context.width,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue[500],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      "SIGN IN",
                                      style: normalTextStyle.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(100),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        child: Text(
                          "GUNAKAN PASSWORD",
                          style: normalTextStyle.copyWith(
                            fontSize: 14,
                            color: Colors.blue[900],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _checkLenghtPin(int values) {
    if (controller.textfield.value.length < 6) {
      controller.textfield(controller.textfield + values.toString());
      if (controller.textfield.value.length == 6) {
        Get.dialog(Loading1());

        controller.onCheckPinValidator(
            controller.textfield.value, (Get.arguments ?? "login"));
        controller.textfield("");
      }
    }
  }
}

class CustomNumberButton extends StatelessWidget {
  const CustomNumberButton({
    super.key,
    required this.controller,
    required this.constraints,
    required this.startIndex,
  });

  final AuthController controller;
  final BoxConstraints constraints;
  final int startIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: constraints.maxHeight / 4,
      width: context.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          3,
          (index) => Material(
            elevation: 2,
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(100),
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              highlightColor: Colors.blue[900],
              onTapCancel: () => controller.onClicked(-1),
              onTapDown: (details) => controller.onClicked(index + startIndex),
              onTapUp: (_) => controller.onClicked(-1),
              onTap: () {
                if (controller.textfield.value.length < 6) {
                  _checkLenghtPin(index + startIndex);
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: constraints.maxWidth * 0.26,
                height: constraints.maxWidth * 0.26,
                child: Obx(
                  () => Text(
                    "${index + startIndex}",
                    style: normalTextStyle.copyWith(
                      fontSize: 25,
                      color: (controller.onClicked.value == index + startIndex)
                          ? Colors.white
                          : Colors.blue[900],
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _checkLenghtPin(int values) {
    if (controller.textfield.value.length < 6) {
      controller.textfield(controller.textfield + values.toString());
      if (controller.textfield.value.length == 6) {
        controller.onCheckPinValidator(
            controller.textfield.value, (Get.arguments ?? "login"));
        controller.textfield("");
      }
    }
  }
}
