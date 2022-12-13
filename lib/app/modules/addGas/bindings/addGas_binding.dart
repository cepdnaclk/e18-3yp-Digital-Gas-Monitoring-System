import 'package:get/get.dart';

import '../controllers/addGas_controller.dart';

class AddGasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddGasController>(
      () => AddGasController(),
    );
  }
}
