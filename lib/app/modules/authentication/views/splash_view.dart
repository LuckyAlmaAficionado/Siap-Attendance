import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SplashView extends GetView {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
              ]),
        ),
        child: Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 1),
            duration: Duration(seconds: 1),
            builder: (context, value, child) {
              return Transform.scale(
                // Menentukan batasan maksimum dan minimum untuk skala
                scale: value.clamp(0, 0.5),
                child: child,
              );
            },
            child: Image.asset(
              "assets/images/img_logo.png",
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
