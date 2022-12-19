import 'package:bluetoothapp/app/components/data_input.dart';
import 'package:bluetoothapp/app/components/enter_button.dart';
import 'package:bluetoothapp/app/components/input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';



class LoginView extends GetView<LoginController> {

  final controller = Get.find();
  TextEditingController phoneController = TextEditingController();

  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Container(
                                  constraints: const BoxConstraints(maxHeight: 340),
                                  margin: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Image.asset('assets/images/otp1.jpeg')),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 5,right: 5,bottom: 20),
                          child:  Text('Enter your Phone Number',
                              style: TextStyle(color: Colors.indigo[900], fontSize: 20, fontWeight: FontWeight.w800)))
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                          constraints: const BoxConstraints(
                              maxWidth: 500
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(children: <TextSpan>[
                              TextSpan(text: 'We will send you the ', style: TextStyle(color: Colors.black38)),
                              TextSpan(
                                  text: '6 digit ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                              TextSpan(text: 'verification code', style: TextStyle(color: Colors.black38)),
                            ]),
                          )),
                      InputTextField(color: Colors.white, hint: '+94...'),
                      EnterButton(text: 'GENERATE OTP', textColour: Colors.white, buttonColour: Colors.blue, onPressed: (){controller.verifyPhoneNumber();},)

                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


