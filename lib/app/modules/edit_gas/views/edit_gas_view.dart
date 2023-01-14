import 'package:bluetoothapp/app/data/models/gas_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/edit_gas_controller.dart';

class EditGasView extends GetView<EditGasController> {
  const EditGasView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffdf4ad),
     
      body: Obx(() => ListView.builder(
    itemCount: controller.gasList.length,
    itemBuilder: (BuildContext context, int index) {
        return controller.gasList.length == 1
            ? GFListTile(
                padding: EdgeInsets.all(10),
                avatar: GFAvatar(),
                titleText: "Home Gas 1",
                subTitleText: "@Dehiwala Home",
                icon: Icon(Icons.favorite),
                color: Colors.white,
                onTap: () {
                  controller.demoAlert();
                },
              )
            : Dismissible(
                background: Container(color: Colors.red),
                key: UniqueKey(),
                onDismissed: (DismissDirection direction) {
                  print(index);
                  controller.removeGas(index);
                },
                child: GFListTile(
                  padding: EdgeInsets.all(10),
                  avatar: GFAvatar(),
                  titleText: "Home Gas 1",
                  subTitleText: "@Dehiwala Home",
                  icon: Icon(Icons.favorite),
                  color: Colors.white,
                  onTap: () {
                    controller.demoAlert();
                  },
                ),
              );
    },
  ),
));
  }
}
