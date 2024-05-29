import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:talenta_app/app/modules/authentication/views/login_view.dart';
import 'package:talenta_app/app/modules/authentication/views/pin_view.dart';
import 'package:talenta_app/app/modules/authentication/views/splash_view.dart';
import 'package:talenta_app/app/shared/theme.dart';

import '../../home/views/menu_view.dart';
import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthController> {
  const AuthenticationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.checkEmailAndPassword(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashView();
        } else if (snapshot.hasData) {
          var data = snapshot.data;

          String email = data!['email'] ?? "";
          String password = data['password'] ?? "";

          if (email.isNotEmpty && password.isNotEmpty) {
            return FutureBuilder(
              future: controller.hiveCheckPin(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SplashView();
                } else if (snapshot.hasData) {
                  return PinView();
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return MenuView();
                }
                return ErrorWidget();
              },
            );
          } else {
            return LoginView();
          }
        }
        return ErrorWidget();
      },
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "Something error 404",
            style: normalTextStyle.copyWith(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
