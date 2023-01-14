import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../components/enter_button.dart';

class OtpView extends GetView {
  const OtpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: VStack([
      Container(
        
        child: Image.network(
            'https://cdn.dribbble.com/users/3821672/screenshots/7172846/media/bdcf195a8ceaf94cd2e55ee274095c91.gif'),
      ),
      Text(
                  'Enter the 6 digits verification code sent to your number',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  )),
      OtpTextField(
        numberOfFields: 6,
        //enabledBorderColor:Colors.teal,
        //set to true to show as box or false to show as dash
        showFieldAsBox: true,
        //runs when a code is typed in
        onCodeChanged: (String code) {
          //handle validation or checks here
        },
        //runs when every textfield is filled
        onSubmit: (String verificationCode) {
          Get.back(result: verificationCode);
        }, // end onSubmit
      ),
      ElevatedButton(
        child: 'VERIFY & CONTINUE'.text.make(),
        onPressed: () {},
      )
    ],crossAlignment: CrossAxisAlignment.center,alignment: MainAxisAlignment.spaceAround,axisSize: MainAxisSize.max,).px12()));
  }
}
