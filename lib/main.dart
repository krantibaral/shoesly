import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shoesly/constants.dart';
import 'package:shoesly/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //firebase intialization
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
    return MaterialApp(
      title: "Shoesly",
      initialRoute: AppRoutes.initial,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: backgroundColor,
          centerTitle: true,
        ),
      ),
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
