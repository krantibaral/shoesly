import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shoesly/constants.dart';
import 'package:shoesly/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyDvLO0rYAT5hp-QmbkmaiwAP1BQ692PLzk',
              appId: '1:376971489870:android:462caf3b72477fa908491f',
              messagingSenderId: '376971489870',
              projectId: 'shoesly-2fb93'))
      : await Firebase.initializeApp();
  runApp(ShoeslyApp());
}

class ShoeslyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      title: "Cake App",
      initialRoute: AppPages.INITIAL,
      theme: ThemeData(
        fontFamily: 'Mulish',
        appBarTheme: const AppBarTheme(
          backgroundColor: backgroundColor,
          // iconTheme: IconThemeData(color: primaryColor),
          // actionsIconTheme: IconThemeData(color: primaryColor),
          centerTitle: true,
          elevation: 0,
          // color: backgroundColor,
        ),
      ),
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
