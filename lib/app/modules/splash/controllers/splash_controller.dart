import 'package:bluetoothapp/app/data/models/gas_model.dart';
import 'package:bluetoothapp/app/data/services/firebase_service.dart';
import 'package:bluetoothapp/app/modules/home/views/home_view.dart';
import 'package:bluetoothapp/app/modules/scan_qr/views/scan_qr_view.dart';
import 'package:bluetoothapp/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  void onReady() async {
    super.onReady();
    //check whether the login session is stored on the device
    print("Calling onReady() ..............by Splash Controller ");
    await Future.delayed(const Duration(milliseconds: 3000)).then((_) async {
       
      if (FirebaseAuth.instance.currentUser?.uid == null) {
        //if user session is not available then send to login page
        Get.offAllNamed(Routes.LOGIN);
      } else {
        // logged
        await FirebaseServices
            .initializeUser(); //to add all gases under the users account
        (Gases.macAddresses.isNotEmpty)
            ? Get.offAllNamed(Routes.HOME)
            : ScanQR();
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
