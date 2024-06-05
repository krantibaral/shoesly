import 'package:get/get.dart';
import 'package:shoesly/home/home_view.dart';
import 'package:shoesly/home/home_binding.dart';
import 'package:shoesly/home/widgets/shoes_detail.dart';
import 'package:shoesly/splash/splash_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      // binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.HOME_SCREEN,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SHOES_DETAIL,
      page: () => const ShoesDetail(),
      // binding: HomeBinding(),
    ),
  ];
}
