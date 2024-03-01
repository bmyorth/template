import 'package:get/get.dart';

import '../pages/home/home_binding.dart';
import '../pages/home/home_page.dart';
import '../pages/login/login_binding.dart';
import '../pages/login/login_page.dart';
import '../pages/overview/overview_binding.dart';
import '../pages/overview/overview_page.dart';
import '../pages/splash/splash_binding.dart';
import '../pages/splash/splash_page.dart';
import 'app_middleware.dart';

//...

class AppPages {
  //Declaro las rutas estaticas para poder llamarla si equivocación
  static final GetPage splashPage = GetPage(
    name: '/splash',
    page: () => const SplashPage(),
    binding: SplashBinding(),
  );

  static final GetPage overview = GetPage(
    name: '/overview',
    page: () => const OverviewPage(),
    binding: OverviewBinding(),
  );

  static final GetPage login = GetPage(
    name: '/login',
    page: () => const LoginPage(),
    binding: LoginBinding(),
  );

  static final GetPage home = GetPage(
    name: '/home',
    page: () => const HomePage(),
    binding: HomeBinding(),
    middlewares: [AppMiddleware()],
  );

  static final List<GetPage> pages = [
    splashPage,
    overview,
    login,
    home,
  ];
}
