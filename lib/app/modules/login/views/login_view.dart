import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {

  final controller = Get.find();
  LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginView'),
        centerTitle: true,
      ),
      body: Center(
        child: TextButton(
  style: TextButton.styleFrom(
    primary: Colors.blue,
    onSurface: Colors.red,
  ),
  onPressed: (){
    controller.verifyPhoneNumber();
  },
  child: Text('Verify Phone Number'),
)
      ),
    );
  }
}
