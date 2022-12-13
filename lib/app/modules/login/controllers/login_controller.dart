import 'package:bluetoothapp/app/data/services/firebase_service.dart';
import 'package:bluetoothapp/app/modules/login/views/otp_view.dart';
import 'package:bluetoothapp/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../data/models/user_model.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+94773785263',
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!
        print('.......AutomaticNumberVerification........');
        // Sign the user in (or link) with the auto-generated credential
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }

        // Handle other errors
      },
      codeSent: (String verificationId, int? resendToken) async {
        print('.......CodeIsSent........');
        var smsCode = await Get.to(OtpView());
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);
        // Sign the user in (or link) with the credential
        _auth
            .signInWithCredential(credential)
            .then((UserCredential user) async {
          UserModel.uid = user.user!.uid; //set uid of UserModel
          String userName = "";

          //ask username if the username is not exists in firestore
          bool exists = await FirebaseServices.checkWhetherUserNameIsThere();
          if (!exists) {
            Get.defaultDialog(
                content: Form(
              key: _formKey,
              child: VStack([
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Enter your name',
                  ),
                  // use the validator to return an error string (or null) based on the input text
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Can\'t be empty';
                    }
                    if (text.length < 8) {
                      return 'Too short';
                    }
                    return null;
                  },

                  onSaved: (value) {
                    userName = value.toString();
                  },
                ),
                GFButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      print(
                          "...................User Submission Initialized ...............");
                      UserModel.userName = userName;
                      await FirebaseServices.addUser();
                    }
                  },
                  text: "Sign Up",
                  color: GFColors.PRIMARY,
                )
              ]),
            ));
          } else {
            Get.offAllNamed(Routes.HOME);
          }
        }).catchError((e) {
          print(e);
        });
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
