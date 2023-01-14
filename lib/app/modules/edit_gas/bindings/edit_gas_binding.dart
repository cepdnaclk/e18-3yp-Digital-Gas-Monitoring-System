import 'package:get/get.dart';

import '../controllers/edit_gas_controller.dart';

class EditGasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditGasController>(
      () => EditGasController(),
    );
  }
}
