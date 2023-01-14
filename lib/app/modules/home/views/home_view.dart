import 'package:bluetoothapp/app/components/gas_container.dart';
import 'package:bluetoothapp/app/components/home_container.dart';
import 'package:bluetoothapp/app/data/models/gas_model.dart';
import 'package:bluetoothapp/app/data/models/user_model.dart';
import 'package:bluetoothapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final controller1 =
      Get.put(HomeController(label: "controller1"), tag: "controller1");
  final controller2 =
      Get.put(HomeController(label: "controller2"), tag: "controller2");
  

  
  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    
    return Scaffold(
      
        appBar: AppBar(
          
        ),
        drawer: GFDrawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              GFDrawerHeader(
                currentAccountPicture: GFAvatar(
                  radius: 80.0,
                  backgroundImage: NetworkImage(
                      "https://robohash.org/2e1d8c12493ba12bc0eba06ef2cdb34e?set=set4&bgset=bg1&size=200x200"),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(UserModel.userName??""),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit / Add Gas'),
                onTap: (){
                  Get.toNamed(Routes.EDIT_GAS);
                },
              ),
              ListTile(
                title: Text(''),
                onTap: null,
              ),
            ],
          ),
        ),
        body: VStack([
           Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black38),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Obx(() {
                 
                  return DropdownButton(
                    
                    value: controller1.selectedGasTitle.value,
                    items: controller1.gasList.map((Gas gas) {
                      return DropdownMenuItem<String>(
                        value: gas.macAddress,
                        child: Text(gas.macAddress),
                      );
                    }).toList(),
                    onChanged: ((value) => controller1.onChange(value??"")),
                  );
                }),
              ),
            ),
           
          ],
        ),),
            
          makeCard(controller1).elevation(4).withRounded(value: 10).make(),
          // TODO: Add up your widgets
          // GFItemsCarousel(
          //   rowCount: 3,
          //   children: [
          //     carouselSimpleCard().elevation(20).withRounded().make(),
          //     carouselSimpleCard().elevation(20).withRounded().make(),
          //     carouselSimpleCard().elevation(20).withRounded().make(),
          //   ],
          // ),
          SizedBox(height: 20,),

          makeCard(controller2).elevation(4).withRounded(value: 10).make(),
        ]).p12()

       
        );
  }

  VxCard carouselSimpleCard() {
    return VxCard(VxBox(
        child: VStack(
      [
        Expanded(
          child: Center(
              child: VxCircle(
            child: Center(child: "3".text.xl4.make()),
            border: Border.all(color: Colors.red),
            radius: 100,
            backgroundColor: Colors.white,
          )),
        ),
        "Active Gases".text.make()
      ],
      crossAlignment: CrossAxisAlignment.center,
    )).makeCentered());
  }

  VxCard makeCard(HomeController controller) {
    double width = Get.width;
    double height = Get.height;

    return VxCard(VxBox(
      child: HStack(
        [
          Image.asset(
              "assets/images/${controller.label == "controller1" ? controller.image1 : controller.image2}",
              width: width * 0.5,
              fit: BoxFit.fill),
          Expanded(
            child: FutureBuilder(
                future: (controller.label == "controller1")
                    ? controller.readGasLevel()
                    : controller.readLeakageLevel(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return VStack([
                      Expanded(
                          child: (snapshot.data.toString())
                              .text
                              .size(50)
                              .fontWeight(FontWeight.w500)
                              .makeCentered()),
                      HStack(
                        [
                          CircleAvatar(child: Icon(Icons.face,color: Colors.white,),),
                          ElevatedButton.icon(onPressed: (){
                             Get.toNamed(Routes.ANALYICS_DASHBOARD);
                          }, icon: Icon(Icons.remove_red_eye_outlined), label: "make".text.make(),)],
                        alignment: MainAxisAlignment.spaceBetween,
                        axisSize: MainAxisSize.max,
                      ),
                    ], crossAlignment: CrossAxisAlignment.center)
                        .paddingOnly(right: 10);
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          )
        ],
        crossAlignment: CrossAxisAlignment.stretch,
      ),
    ).height(height * 0.25).width(double.infinity).make());
  }

 
}
