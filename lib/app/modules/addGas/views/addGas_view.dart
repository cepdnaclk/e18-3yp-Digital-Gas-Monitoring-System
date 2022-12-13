import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/addGas_controller.dart';

class AddGasView extends GetView<AddGasController> {
  final controller = Get.find();
  AddGasView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
