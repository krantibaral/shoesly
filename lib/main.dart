import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoesly/constants.dart';
import 'package:shoesly/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'YOUR_API_KEY',
              appId: 'YOUR_APP_ID',
              messagingSenderId: 'YOUR_SENDER_ID',
              projectId: 'YOUR_PROJECT_ID'))
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
      title: "Cake App",
      initialRoute: AppRoutes.initial,
      routes: AppRoutes.routes,
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
      debugShowCheckedModeBanner: false,
    );
  }
}
