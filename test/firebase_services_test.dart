import 'package:bluetoothapp/app/data/models/user_model.dart';
import 'package:bluetoothapp/app/data/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async{
  UserModel.phoneNumber = "+94773785263";
  
 

  test("Check If the User Exsists", ()async{
     await Firebase.initializeApp();
     UserModel.uid = "TpYuUPgmhAXUg77u1Hh93Vi7hn83";
     bool isUserExists =  await FirebaseServices.checkWhetherUserNameIsThere();
     expect(true, isUserExists);
  });

  test("Check If the User Exsists", ()async{
    await Firebase.initializeApp();
    UserModel.uid = "ZpYuUPgmhAXUg77u1Hh93Vi7hn83";
     bool isUserExists =  await FirebaseServices.checkWhetherUserNameIsThere();
     expect(false, isUserExists);
  });
}