import 'package:firebase_auth/firebase_auth.dart'as _auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pin_put/pin_put.dart';

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


getMobileFormWidget(context){
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 90),
      child:  TextField(
          controller: phoneNumberController,
          decoration: InputDecoration(
            hintText: "Phone Number"
          ),
        ),
        ),
        SizedBox(height: 16,),
        FlatButton(onPressed: () async{
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
           timeout: Duration(seconds: 40),
              codeAutoRetrievalTimeout: (verificationId)async {
                this.verificationId=verificationId;
           showLoading=false;

              },

          );
        }
        , child: Text("SEND")),
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
            , child: Text("VERIFY")),


      ],
    );

  }


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

