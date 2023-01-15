import 'package:bluetoothapp/app/data/models/gas_model.dart';
import 'package:bluetoothapp/app/modules/scan_qr/views/scan_qr_view.dart';
import 'package:bluetoothapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/edit_gas_controller.dart';

class EditGasView extends GetView<EditGasController> {
  const EditGasView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => VStack(
        [
          Expanded(
            child: ListView.builder(
              itemCount: controller.gasList.length,
              itemBuilder: (BuildContext context, int index) {
              return controller.gasList.length == 1
                  ? GFListTile(
                    avatar: CircleAvatar(child: "1".text.make()),
                      padding: EdgeInsets.all(20),
                      titleText:controller.gasList[0],
                      subTitleText: "@Dehiwala Home",
                      color: Color.fromARGB(255, 228, 235, 238),
                      
                     
                    )
                  : Dismissible(
                      background: Container(color: Colors.red),
                      key: UniqueKey(),
                      onDismissed: (DismissDirection direction) {
                        controller.removeGas(index);
                      },
                      child: GFListTile(
                    avatar: CircleAvatar(child: "${index+1}".text.make()),
                      padding: EdgeInsets.all(20),
                      titleText:controller.gasList[index],
                      subTitleText: "@Dehiwala Home",
                      color: Color.fromARGB(255, 228, 235, 238),
                      enabled: true,
                     
                    )
                    );
              },
            ),
          ),
          ElevatedButton.icon(onPressed: (){
            Get.toNamed(Routes.SCAN_QR);
            

          },label: "Add New Gas".text.make(),icon: Icon(Icons.add))
        ],
        crossAlignment: CrossAxisAlignment.stretch,
      ).px12(),
));
  }
}
