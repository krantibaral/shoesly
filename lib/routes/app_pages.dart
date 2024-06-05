
import 'package:get/get.dart';
import 'package:shoesly/home/homeView.dart';
import 'package:shoesly/splash/splash_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () =>  SplashScreenView(),
      // binding: SplashScreenBinding(),
    ),
      GetPage(
      name: _Paths.HOME_SCREEN,
      page: () =>  HomeView(),
      // binding: HomeBinding(),
    ),
     
  ];
}