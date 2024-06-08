import 'dart:developer';

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
              future: controller.pinValidator(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While the future is resolving, show a loading view (could be SplashView)
                  return SplashView();
                } else if (snapshot.hasError) {
                  // Handle the error case, maybe show an error view or a retry option
                  return ErrorWidget(); // This could be any widget to display the error
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    // If we have data, check its value
                    print("Snapshot Data: ${snapshot.data}");
                    if (snapshot.data != null) {
                      // If data is not null, show PinView
                      return PinView();
                    } else {
                      // If data is null, show MenuView
                      return MenuView();
                    }
                  } else {
                    // If the future completed but no data is present
                    return MenuView();
                  }
                } else {
                  // This case shouldn't normally happen, but it's good to handle it
                  return SplashView();
                }
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
