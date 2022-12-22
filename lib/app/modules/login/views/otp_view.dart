import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import '../../../components/enter_button.dart';

class OtpView extends GetView {
  const OtpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.teal,
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 16,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,

          brightness: Brightness.light,
          title: Center(
            child: Text('OTP VERIFICATION',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
            ),),
          ),backgroundColor: Colors.teal,
        ),
        body: SafeArea(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              constraints: const BoxConstraints(maxHeight: 340),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 10),
                              child: Image.network(
                                  'https://cdn.dribbble.com/users/3821672/screenshots/7172846/media/bdcf195a8ceaf94cd2e55ee274095c91.gif'),),
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child:  Center(
                                  child: Text(
                                      'Enter the 6 digits verification code sent to your number',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                      )))),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(

                          constraints: const BoxConstraints(maxWidth: 500),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 10),
                          child: OtpTextField(
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
                        ),
                        EnterButton(
                          text: 'VERIFY & CONTINUE',
                          textColour: Colors.white,
                          buttonColour: Colors.teal,
                          onPressed: () {},
                        )
               
              ],
            ),
          ),
        ));
  }
}
