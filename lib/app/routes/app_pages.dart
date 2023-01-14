import 'package:get/get.dart';

import '../modules/analyics_dashboard/bindings/analyics_dashboard_binding.dart';
import '../modules/analyics_dashboard/views/analyics_dashboard_view.dart';
import '../modules/edit_gas/bindings/edit_gas_binding.dart';
import '../modules/edit_gas/views/edit_gas_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/scan_qr/bindings/scan_qr_binding.dart';
import '../modules/scan_qr/views/scan_qr_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

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
      name: _Paths.ANALYICS_DASHBOARD,
      page: () => AnalyicsDashboardView(),
      binding: AnalyicsDashboardBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_GAS,
      page: () => const EditGasView(),
      binding: EditGasBinding(),
    ),
    GetPage(
      name: _Paths.SCAN_QR,
      page: () => ScanQR(),
      binding: ScanQrBinding(),
    ),
  ];
}
