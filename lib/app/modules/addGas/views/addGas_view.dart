import 'package:bluetoothapp/app/components/enter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../controllers/addGas_controller.dart';
import 'addGas_view.dart';
import 'scan_QR.dart';

class AddGasView extends GetView<AddGasController> {
  final controller = Get.find();
  //MobileScannerController cameraController = MobileScannerController();
  AddGasView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(backgroundColor: const Color(0xFFFFFF),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(50),bottomRight: Radius.circular(50),topRight: Radius.circular(10),bottomLeft: Radius.circular(10))),
                //color: Colors.blueGrey,
                height: height/8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Hey Mark!',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),),
                    SizedBox(width: 5,),

                    ProfilePicture(
                      name: 'Vilakshan',
                      radius: 20,
                      fontsize: 20,
                      tooltip: true,
                      img: 'https://avatars.githubusercontent.com/u/73380111?v=4',
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                  constraints: const BoxConstraints(maxHeight: 340),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Image.asset('assets/images/addGas.jpg')),),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text('Scan QR CODE to add the gas', style: TextStyle(color: Colors.indigo[800],
                fontSize: 20,fontWeight: FontWeight.bold
                ),),
             ),
            EnterButton(text: 'PROCEED', textColour: Colors.white, buttonColour: Colors.cyan ,onPressed: (){Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScanQR()),
            );})
          ],
        ),
      ),
    );
  }
}
