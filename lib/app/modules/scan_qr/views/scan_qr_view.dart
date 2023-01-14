import 'package:bluetoothapp/app/modules/login/controllers/login_controller.dart';
import 'package:bluetoothapp/app/modules/scan_qr/controllers/scan_qr_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';





class ScanQR extends GetView<ScanQrController> {
  final controller = Get.find();
  MobileScannerController cameraController = MobileScannerController();
  ScanQR({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.teal,
          title: const Text('PeGas'),
          actions: [
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.torchState,
                builder: (context, state, child) {
                  switch (state as TorchState) {
                    case TorchState.off:
                      return const Icon(Icons.flash_off, color: Colors.grey);
                    case TorchState.on:
                      return const Icon(Icons.flash_on, color: Colors.yellow);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.toggleTorch(),
            ),
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.cameraFacingState,
                builder: (context, state, child) {
                  switch (state as CameraFacing) {
                    case CameraFacing.front:
                      return const Icon(Icons.camera_front);
                    case CameraFacing.back:
                      return const Icon(Icons.camera_rear);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.switchCamera(),
            ),
          ],
        ),
        body: MobileScanner(
            allowDuplicates: false,
            controller: cameraController,
            onDetect: (barcode, args) async{
              if (barcode.rawValue == null) {
                print('Failed to scan Barcode');
              } else {
                controller.qrCodeResp = barcode.rawValue!.trim();
                print('Barcode found! ${controller.qrCodeResp}');               
                await controller.checkWhetherGasIsAvailable();
              }
            }));
  }
}
