import 'package:get/get.dart';

import '../controllers/analyics_dashboard_controller.dart';

class AnalyicsDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnalyicsDashboardController>(
      () => AnalyicsDashboardController(),
    );
  }
}
