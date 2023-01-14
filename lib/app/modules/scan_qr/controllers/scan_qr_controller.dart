import 'package:bluetoothapp/app/components/custom_dialog.dart';
import 'package:bluetoothapp/app/data/models/gas_model.dart';
import 'package:bluetoothapp/app/data/services/firebase_service.dart';
import 'package:bluetoothapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScanQrController extends GetxController {
  //TODO: Implement ScanQrController
  Rx<bool> isPressed = Rx<bool>(false);
  String qrCodeResp = "";

  final count = 0.obs;
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

  Future<void> checkWhetherGasIsAvailable() async {
    bool isAlreadyAdded = Gases.gasList.contains(Gas(qrCodeResp));
    if (!isAlreadyAdded) {
      FirebaseServices.checkWhetherGasIsAvailable(qrCodeResp)
          .then((isAvailable) async {

        //to check whether the gas is valid, it is manufactured by us
        if (isAvailable) {
          FirebaseServices.addGas(qrCodeResp).then((value) {
            (value)?Get.offAllNamed(Routes.HOME):null;
          });
        //OtherWise
        }else{
          
          Get.dialog(CustomDialog(
                  circleAvatar: CircleAvatar(
                    backgroundColor: Colors.red[600],
                    radius: 60,
                    child: Icon(
                      Icons.warning_amber,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  description: 'This Is not a valid Device',
                  title: "Error",
                  onpressed: () {
                    Get.offNamed(Routes.SCAN_QR);
                  },
                ),
                barrierColor: Colors.transparent,
                barrierDismissible: false);
        }
        
      });
    }
  }
}
