
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shoesly/constants.dart';
import 'package:shoesly/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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