import 'package:bluetoothapp/app/data/services/firebase_service.dart';
import 'package:bluetoothapp/app/routes/app_pages.dart';
import 'package:get/get.dart';

class AddGasController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  String qrCodeResp = "";
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> checkWhetherGasIsAvailable()async{
    bool isAvilable = await FirebaseServices.checkWhetherGasIsAvailable(qrCodeResp);
    print(".......isAvilable.......$isAvilable....................");
    if(isAvilable){
      Get.offAllNamed(Routes.HOME);
    }
  }



}
