import 'package:bluetoothapp/app/components/data_input.dart';
import 'package:bluetoothapp/app/components/enter_button.dart';
import 'package:bluetoothapp/app/components/input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:velocity_x/velocity_x.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final controller = Get.find();
  TextEditingController phoneController = TextEditingController();

  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    TextEditingController textEditController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final buttonFocusNode = FocusNode();
    final textFieldFocusNode = FocusNode();
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: Get.height * 0.9),
          child: VStack(
            [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  "https://cdn.dribbble.com/users/1817357/screenshots/5799171/media/4f73eb9e6b695a83be39ff71b54b5c4c.gif",
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 5, right: 5, bottom: 20),
                  child: Text('Enter your phone number',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w800))),
              Container(
                  child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: 'We will send you the ',
                      style: TextStyle(color: Colors.black38)),
                  TextSpan(
                      text: '6 digit ',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: 'verification code',
                      style: TextStyle(color: Colors.black38)),
                ]),
              )),

              InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  controller.phoneNumber = number.phoneNumber ?? "";
                },
                onInputValidated: (bool value) {
                  if (value) {
                    controller.isPhoneNumeberValid.value = value;
                  } else {
                    controller.isPhoneNumeberValid.value = value;
                  }
                },
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                ignoreBlank: true,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                selectorTextStyle: TextStyle(color: Colors.black),
                initialValue: PhoneNumber(
                  isoCode: 'LK',
                ),
                formatInput: false,
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                inputBorder: OutlineInputBorder(),
                onSaved: (value) {
                  print(value.phoneNumber);
                },
              ),
              Obx(() => ElevatedButton(
                  onPressed: (!controller.isPhoneNumeberValid.value)
                      ? null
                      : () {
                          controller.verifyPhoneNumber();
                          Get.dialog(
                            GFLoader(
                                size: GFSize.LARGE, type: GFLoaderType.circle),
                          );
                        },
                  child: "GENERATE OTP".text.white.make())),
            ],
            crossAlignment: CrossAxisAlignment.center,
            alignment: MainAxisAlignment.spaceEvenly,
            axisSize: MainAxisSize.max,
          ).px12(),
        ),
      )),
    );
  }
}
