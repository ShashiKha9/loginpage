import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart'as _auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'homepgae_screen.dart';
 enum MobileVerificationState{
  Show_Mobile_Form_State,
  Show_Otp_Form_State,

}

class OtpScreen extends StatefulWidget {
@override
  OtpScreenState createState() => OtpScreenState();
}
class OtpScreenState extends State<OtpScreen>{

  MobileVerificationState currentState=MobileVerificationState.Show_Mobile_Form_State;
  late String dialCodeDigits = "+00";
  final  GlobalKey<ScaffoldState> _scaffoldkey =GlobalKey<ScaffoldState>();
   late String verificationId;
  static bool  showLoading= false;
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  FirebaseAuth _auth =FirebaseAuth.instance;

   Future<void> signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
     setState(() {
       showLoading= true;
     });
     try {
       final authCredential = await _auth.signInWithCredential(
           phoneAuthCredential);
       setState(() {
         showLoading= true;
       });
       if(authCredential?.user!= null){
         Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
       }
     } on FirebaseAuthException catch(e){
       setState(() {
         showLoading=false;
       });

       _scaffoldkey.currentState!.showSnackBar(SnackBar(content: Text(e.message!)));

     }
   }
   void starttimer(){
     const onsec= Duration(seconds: 1);
     Timer timer=Timer.periodic(onsec,(timer){
       if(start==0){
         setState(() {
           timer.cancel();
           wait=false;
         });

       }else{
         setState(() {
           start--;

         });
       }

     });

   }


getMobileFormWidget(context){
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 90),
      child:Container(
      child:  TextField(
          controller: phoneNumberController,
          decoration: InputDecoration(
            hintText: "Phone Number",
            prefixIcon: Padding(padding: EdgeInsets.symmetric(vertical: 14,horizontal: 15),
  child:Text("(+91)",style: TextStyle(fontSize: 16),)
            )
          ),

        ),
        ),
        ),
        SizedBox(height: 16,),
        FlatButton(onPressed: () async{
          starttimer();
          setState(() {
            showLoading=true;
          });
         await _auth.verifyPhoneNumber(phoneNumber: phoneNumberController.text,

              verificationCompleted: (phoneAuthCredential)async{
                setState(() {

                  showLoading=false;
                });

              },
              verificationFailed: (verificationFailed)async {
                setState(() {
                  showLoading=false;
                });
                _scaffoldkey.currentState!.showSnackBar(SnackBar(content: Text(verificationFailed.message!)));

              },
              codeSent: (verificationId,resendingToken)async{
            setState(() {
              currentState=MobileVerificationState.Show_Otp_Form_State;
              this.verificationId=verificationId;
              showLoading= false;
            });

              },
              codeAutoRetrievalTimeout: (verificationId)async {

              },

          );

        }

        ,
          child: Text("SEND"),
        ),
      ],
    );

  }
  getOtpFormWidget(context){
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 90),
       child: TextField(
          controller: otpController,
          decoration: InputDecoration(
              hintText: "Enter OTP"
          ),
        ),
        ),
        SizedBox(height: 16,),
        FlatButton(onPressed: () {
          PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: otpController.text,);
          signInWithPhoneAuthCredential(phoneAuthCredential);
        }
            , child: Text("Get Started")),
       Wrap(
         children: [
           Text("Send OTP again in ",style: TextStyle(
             fontSize: 14
           ),),
           Text("00:$start ",style: TextStyle(
               fontSize: 14,color: Colors.red
           ),),
           Text("sec ",style: TextStyle(
               fontSize: 14
           ),),
    ]
       ),
        SizedBox(
          height: 10,
        ),


    RichText(text: TextSpan(
    children: [
    TextSpan(
    text: "Did not get otp",
    style: TextStyle(fontSize: 14,color: Colors.black)
    ),
    TextSpan(
    text: " resend?",
    style: TextStyle(fontSize: 16,color: wait? Colors.blue:Colors.grey),
    recognizer: TapGestureRecognizer()
    ..onTap=wait ?null:(){
      setState(() {
        start=30;
        start--;
        wait= true;
      });
    print("judnu");
    }

    )
    ]
    ))
    ],





    );

  }

int start= 45;
   bool wait = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: showLoading ? Center(
          child: CircularProgressIndicator(),
        ) :currentState==MobileVerificationState.Show_Mobile_Form_State
       ? getMobileFormWidget(context)
       : getOtpFormWidget(context),
      )
    );





}
}

