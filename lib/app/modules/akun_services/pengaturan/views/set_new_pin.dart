import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:talenta_app/app/controllers/authentication_controller.dart';
import 'package:talenta_app/app/shared/utils.dart';

import '../../../../shared/theme.dart';

class SetNewPinView extends StatefulWidget {
  const SetNewPinView({super.key});

  @override
  State<SetNewPinView> createState() => _PinManagetViewState();
}

class _PinManagetViewState extends State<SetNewPinView> {
  RxString pin = "".obs;
  RxInt currentIndex = 0.obs;

  RxBool isFirstAttempt = true.obs;

  late String tempPIN;

  AuthenticationController controller = Get.find<AuthenticationController>();

  FocusNode focusNode = FocusNode();
  TextEditingController _textController = TextEditingController();

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
              Text(
                (isFirstAttempt.value)
                    ? "Masukan PIN baru"
                    : "Masukan ulang PIN",
                style: blackTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: Get.height * 0.08,
                child: Text(
                  (isFirstAttempt.value)
                      ? "Masukan 6 digit PIN baru untuk\nmasuk ke aplikasi Berbakat"
                      : "Masukan ulang 6 digit PIN baru",
                  style: darkGreyTextStyle.copyWith(
                    fontWeight: regular,
                    fontSize: 16,
                  ),
                ),
              ),
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
                  if (isFirstAttempt.value) {
                    if (_textController.text.length == 6) {
                      tempPIN = _textController.text;
                      isFirstAttempt(false);
                      setState(() {
                        _textController.text = "";
                      });
                    }
                  } else {
                    if (_textController.text.length == 6) {
                      // ... cek apakah temp sama pin baru sama
                      if (_textController.text.contains(tempPIN)) {
                        await controller
                            .savePin(_textController.text)
                            .then((value) {
                          Get.back();
                          Utils().snackbarC(
                            "Berhasil..!",
                            "Berhasil mengaktifkan PIN",
                            true,
                          );
                        });
                      } else {
                        // ... jika pin tidak sama
                        Utils().snackbarC(
                          "Oh Tidak..!",
                          "PIN yang anda masukan tidak sama",
                          false,
                        );
                      }

                      setState(() {
                        _textController.text = "";
                      });
                    }
                  }

                  setState(() {});
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
