part of 'app_pages.dart';


abstract class Routes {
  Routes._();

  static const SPLASH_SCREEN = _Paths.SPLASH_SCREEN;
  static const HOME_SCREEN = _Paths.HOME_SCREEN;
  static const SHOES_DETAIL = _Paths.SHOES_DETAIL;
  
}

abstract class _Paths {
  static const SPLASH_SCREEN = '/splash-screen';
  static const HOME_SCREEN = '/home';
  static const SHOES_DETAIL = '/shoes-detail';
}