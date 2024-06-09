import 'package:get/get.dart';
import 'package:shoesly/cart/cart_details.dart';
import 'package:shoesly/cart/order_detail_screen.dart';
import 'package:shoesly/filter/filter_screen.dart';
import 'package:shoesly/home/home_view.dart';
import 'package:shoesly/home/home_binding.dart';
import 'package:shoesly/detail/shoes_detail.dart';
import 'package:shoesly/splash/splash_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
    ),
    GetPage(
      name: _Paths.HOME_SCREEN,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SHOES_DETAIL,
      page: () => const ShoesDetail(),
    ),
    GetPage(
      name: _Paths.CART_DETAIL,
      page: () => CartDetailsScreen(),
    ),
 
  
  ];
}
