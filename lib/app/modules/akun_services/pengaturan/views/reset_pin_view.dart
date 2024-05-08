import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talenta_app/app/controllers/authentication_controller.dart';
import 'package:talenta_app/app/shared/theme.dart';
import 'package:talenta_app/app/shared/utils.dart';

class ResetPinView extends StatefulWidget {
  const ResetPinView({super.key});

  @override
  State<ResetPinView> createState() => _UbahPinViewState();
}

class _UbahPinViewState extends State<ResetPinView> {
  // Menggunakan RxString untuk memungkinkan pemantauan perubahan nilai
  RxString pin = ''.obs;

  // TextEditingController untuk TextField
  late TextEditingController _textController;

  //
  RxBool isLatestPassTrue = false.obs;

  //
  final authC = Get.find<AuthenticationController>();

  FocusNode focusNode = FocusNode();

  int curIndex = 0;

  @override
  void initState() {
    super.initState();

    _textController = TextEditingController();
    // Menampilkan keyboard saat aplikasi dimulai
    Future.delayed(
        Duration.zero, () => FocusScope.of(context).requestFocus(focusNode));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              Obx(() => Text(
                    "Masukan PIN ${(isLatestPassTrue.value) ? "Baru" : "saat ini"}",
                    style: blackTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 18,
                    ),
                  )),
              const SizedBox(height: 10),
              Obx(() => Text(
                    (isLatestPassTrue.value)
                        ? "Masukan 6 digit PIN baru untuk mengubah PIN"
                        : "Masukan 6 digit PIN saat ini untuk mengubah PIN",
                    style: darkGreyTextStyle.copyWith(
                      fontWeight: regular,
                      fontSize: 14,
                    ),
                  )),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDot(0),
                  _buildDot(1),
                  _buildDot(2),
                  _buildDot(3),
                  _buildDot(4),
                  _buildDot(5),
                ],
              ),

              // TextField yang tersembunyi untuk menampilkan keyboard
              TextField(
                style: whiteTextStyle,
                autofocus: true,
                focusNode: focusNode,
                controller: _textController,
                keyboardType: TextInputType.number,
                onChanged: (value) async {
                  if (isLatestPassTrue.value) {
                    if (_textController.text.length == 6) {
                      authC.savePin(_textController.text);
                      Get.back();
                      Utils().snackbarC(
                        "Berhasil...!",
                        "Berhasil mengubah PIN",
                        true,
                      );
                      setState(() {
                        _textController.text = "";
                      });
                    }
                  } else {
                    if (_textController.text.length == 6) {
                      if (await authC.getPin(_textController.text)) {
                        isLatestPassTrue(true);
                        setState(() {
                          _textController.text = "";
                        });

                        return;
                      }

                      setState(() {
                        _textController.text = "";
                        Utils().snackbarC("Oh Tidak...!",
                            "Sepertinya kamu memasukan PIN yang salah", false);
                      });
                    }
                  }

                  setState(() {});

                  // if (isLatestPassTrue.value) {
                  //   print('testing');
                  //   if (curIndex < 6) {
                  //     _addNumber(int.parse(value[curIndex]));
                  //     if (curIndex == 5) {
                  //       authC.savePin(_textController.text);
                  //       setState(() {
                  //         _textController.text = "";
                  //         pin.value = "";
                  //         curIndex = 0;
                  //       });
                  //       Get.back();
                  //       Utils().snackbarC(
                  //           "Berhasil", "berhasil mengubah PIN", true);
                  //       return;
                  //     }
                  //     curIndex++;
                  //   }
                  // } else {
                  //   if (curIndex < 6) {
                  //     _addNumber(int.parse(value[curIndex]));
                  //     if (curIndex == 5) {
                  //       if (await authC.getPin(_textController.text)) {
                  //         isLatestPassTrue(true);
                  //         setState(() {
                  //           _textController.text = "";
                  //           pin.value = "";
                  //           curIndex = 0;
                  //         });
                  //         return;
                  //       }
                  //       setState(() {
                  //         _textController.text = "";
                  //         pin.value = "";
                  //         curIndex = 0;
                  //       });
                  //       Utils().snackbarC("Oh Tidak..!",
                  //           "Sepertinya kamu memasukan PIN yang salah", false);
                  //       return;
                  //     }
                  //     curIndex++;
                  //   } else {
                  //     print("maksimal");
                  //   }
                  // }
                },
                showCursor: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method untuk membangun dot yang menunjukkan status PIN
  Widget _buildDot(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      width: 15.0,
      height: 15.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            _textController.text.length > index ? darkBlueColor : darkGreyColor,
      ),
    );
  }
}
