import 'package:get/get.dart';


import '../modules/addGas/bindings/addGas_binding.dart';
import '../modules/addGas/views/addGas_view.dart';
import '../modules/analyics_dashboard/bindings/analyics_dashboard_binding.dart';
import '../modules/analyics_dashboard/views/analyics_dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;


  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ADDGAS,
      page: () => AddGasView(),
      binding: AddGasBinding(),
    ),
    GetPage(
      name: _Paths.ANALYICS_DASHBOARD,
      page: () => const AnalyicsDashboardView(),
      binding: AnalyicsDashboardBinding(),
    ),
  ];
}
