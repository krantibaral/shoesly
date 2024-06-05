
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shoesly/routes/app_pages.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to home screen after 6 seconds
    Future.delayed(const Duration(seconds: 6), () {
      Get.offAllNamed(Routes.HOME_SCREEN);
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // Optional: Add background image if needed
          // image: DecorationImage(
          //   image: AssetImage('assets/cake-logo.png'),
          //   fit: BoxFit.fitHeight,
          // ),
        ),
        alignment: Alignment.center,
        child: const Text("Shoesly")
      )
    );
  }
}
