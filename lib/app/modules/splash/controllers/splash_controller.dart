import 'package:bluetoothapp/app/modules/home/views/home_view.dart';
import 'package:bluetoothapp/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController
  final getStorage = GetStorage();
  

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    print("Calling init ..............by Splash Controller ");
  }

  @override
  void onReady() {
    super.onReady();
    //check whether the login session is stored on the device
    print("Calling onReady() ..............by Splash Controller ");
    if(getStorage.read("id")!=null){
      Future.delayed(const Duration(milliseconds: 2000),(){
        Get.offAllNamed(Routes.HOME);
      });
    }else{
        Get.offAllNamed(Routes.LOGIN);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
