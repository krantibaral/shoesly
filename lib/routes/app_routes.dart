part of 'app_pages.dart';


abstract class Routes {
  Routes._();

  static const SPLASH_SCREEN = _Paths.SPLASH_SCREEN;
  static const HOME_SCREEN = _Paths.HOME_SCREEN;
}

abstract class _Paths {
  static const SPLASH_SCREEN = '/splash-screen';
  static const HOME_SCREEN = '/home';
}