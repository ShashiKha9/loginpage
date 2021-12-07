import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:loginpage/Pages/viewvideo_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';



import 'Pages/otp_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await  Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var phone =prefs.getString("phoneNumber");
  runApp(Phoenix(
   child: phone == null? OtpScreen():PageScreen()
  ));
}




