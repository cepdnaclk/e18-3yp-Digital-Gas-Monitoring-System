import 'package:bluetoothapp/app/modules/splash/bindings/splash_binding.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    // Ideal time to initialize
  FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
  await GetStorage.init();
  final color = Color(0xff00acec); // using the color code #fdf4ad
final materialColor = MaterialColor(color.value, <int, Color>{
  50: color,
  100: color,
  200: color,
  300: color,
  400: color,
  500: color,
  600: color,
  700: color,
  800: color,
  900: color,
});

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
       
  primarySwatch: materialColor,
  iconTheme: IconThemeData(
    color: Colors.white
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Color(0xff00acec)), //button color
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white), //text (and icon)
  ),
),
  
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  ),
),
    ),
  );
}
