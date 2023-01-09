import 'package:bluetoothapp/app/components/enter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:velocity_x/velocity_x.dart';

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
    return Scaffold(
      
      body: VStack(
        [
          // TODO: Add up your widgets
          VxBox(
              
              //color: Colors.blueGrey,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Hey Vilakshan!',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),),
                  SizedBox(width: 10,),

                  ProfilePicture(
                    name: 'Vilakshan',
                    radius: 25,
                    fontsize: 20,
                    tooltip: true,
                    img: 'https://avatars.githubusercontent.com/u/73380111?v=4',
                  ),
                ],
              ),
            ).height(Get.height*0.1).withDecoration(BoxDecoration(
                  color: Colors.teal,

                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50),bottomRight: Radius.circular(50),topRight: Radius.circular(10),bottomLeft: Radius.circular(10))),).margin(EdgeInsets.only(bottom: 20)).make(),

            

              Stack(
                children: [
                  Container(
                     
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50), child: Image.asset('assets/images/scan_qrcode.png')
                        // margin: const EdgeInsets.symmetric(horizontal: 8),
                      ),),
                      GFIconButton(icon: Icon(Icons.info_outline_rounded), onPressed: (() {}))
                ],
              ),
           
            GFButton(onPressed: (){
              Get.to(ScanQR());
            },icon: Icon(Icons.qr_code),text: "Scan QR code To Add the Gas",shape: GFButtonShape.pills,)
        ],alignment: MainAxisAlignment.spaceEvenly,crossAlignment: CrossAxisAlignment.center,
      ).p12()
          
             


          
          
        
      
    );
  }
}
