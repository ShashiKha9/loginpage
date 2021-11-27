import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/Pages/viewvideo_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Pages/otp_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await  Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var phone =prefs.getString("phoneNumber");
  runApp(MaterialApp(
      home:OtpScreen()

      // home: phone == null? OtpScreen():PageScreen()
  ));
}



