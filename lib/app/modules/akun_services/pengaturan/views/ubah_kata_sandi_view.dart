import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:talenta_app/app/shared/utils.dart';

import '../../../../shared/theme.dart';

// ignore: must_be_immutable
class UbahKataSandiView extends GetView {
  UbahKataSandiView({Key? key}) : super(key: key);

  RxBool isPassShowing = true.obs;
  RxBool isConfPassShowing = true.obs;

  TextEditingController currentPasswordC = TextEditingController();
  TextEditingController newPasswordC = TextEditingController();
  TextEditingController newConfPasswordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ubah kata sandi',
          style: appBarTextStyle,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                'Ubah Password',
                style: blackTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Password Sekarang',
                style: blackTextStyle.copyWith(
                  fontWeight: regular,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: Get.width,
                height: 50,
                child: TextField(
                  controller: currentPasswordC,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Password Baru',
                style: blackTextStyle.copyWith(
                  fontWeight: regular,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: Get.width,
                height: 50,
                child: Obx(
                  () => TextField(
                    controller: newPasswordC,
                    obscureText: isPassShowing.value,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
                      suffixIcon: IconButton(
                        onPressed: () {
                          isPassShowing.toggle();
                        },
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: darkGreyColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: lightGreyColor,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Konfirmasi Password Baru',
                style: blackTextStyle.copyWith(
                  fontWeight: regular,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: Get.width,
                height: 50,
                child: Obx(
                  () => TextField(
                    controller: newConfPasswordC,
                    obscureText: isConfPassShowing.value,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
                      suffixIcon: IconButton(
                        onPressed: () {
                          isConfPassShowing.toggle();
                        },
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: darkGreyColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: lightGreyColor,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              CustomButton(
                title: "Simpan perubahan",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  validatorTextfield(
    String curPassword,
    String newPassword,
    String newConfPassword,
  ) {
    if (curPassword.isEmpty) {
      Utils().snackbarC("Oh Tidak...!", "Isi semua kolom!", false);
      return false;
    } else if (newPassword.isEmpty) {
      Utils().snackbarC("Oh Tidak...!", "Isi semua kolom!", false);
      return false;
    } else if (newConfPassword.isEmpty) {
      Utils().snackbarC("Oh Tidak...!", "Isi semua kolom!", false);
      return false;
    } else if (!newPassword.contains(newConfPassword)) {
      Utils().snackbarC(
        "Oh Tidak...!",
        "Password baru dan confirm password tidak sama!",
        false,
      );
      return false;
    } else {
      Utils().snackbarC("Berhasil..!", "data berhasil", true);
      return true;
    }
  }
}
