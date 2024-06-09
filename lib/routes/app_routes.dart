import 'package:flutter/material.dart';
import 'package:shoesly/cart/cart_details.dart';
import 'package:shoesly/detail/shoes_detail.dart';
import 'package:shoesly/home/home_view.dart';
import 'package:shoesly/splash/splash_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String shoesDetail = '/shoes_detail';
  static const String homePage = '/home_page';
  static const String cartDetail = '/cart_detail';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => SplashScreen(),
    homePage: (context) => const HomeView(),
    shoesDetail: (context) => const ShoesDetail(),
    cartDetail: (context) => CartDetailsScreen(),
  };
}
