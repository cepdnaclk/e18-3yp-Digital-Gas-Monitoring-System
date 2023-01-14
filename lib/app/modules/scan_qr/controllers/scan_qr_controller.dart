import 'dart:async';

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
    Completer completer = Completer();
    bool isAlreadyAdded = Gases.gasList.any((object) => object.macAddress == qrCodeResp);
    Gases.gasList.map((e) => print(e.macAddress));
    if (!isAlreadyAdded) {
      FirebaseServices.checkWhetherGasIsAvailable(qrCodeResp)
          .then((isAvailable) async {

        //to check whether the gas is valid, it is manufactured by us
        if (isAvailable) {
          FirebaseServices.addGas(qrCodeResp).then((value) {
            if(value){
                Gases.gasList.add(Gas(qrCodeResp));
                Get.offAllNamed(Routes.HOME);
            }
          });
          completer.complete();
        //OtherWise
        }else{
          
          await Get.dialog(CustomDialog(
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
                    print("close this dialog");
                    Get.back();
                    completer.complete();
                  },
                ),
                barrierColor: Colors.transparent,
                barrierDismissible: false);
        }
        
      });
        return completer.future;
    }
Get.offAllNamed(Routes.HOME);
  
  }
}
