import 'package:firebase_auth/firebase_auth.dart'as _auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pin_put/pin_put.dart';

import 'homepgae_screen.dart';

class OtpScreen extends StatefulWidget {
@override
  OtpScreenState createState() => OtpScreenState();
}
class OtpScreenState extends State<OtpScreen>{
  final  GlobalKey<ScaffoldState> _scaffoldkey =GlobalKey<ScaffoldState>();
  late String _verificationId;
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 30),
       child:   Text("OTP Verification",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700),)
          ),
          TextFormField(
              keyboardType: TextInputType.phone,
              controller: _phoneNumber,
              decoration: InputDecoration(
                labelText: "Enter Phone",
                contentPadding: EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
              )),
          Container(
            child: RaisedButton(onPressed: (){
              verifyPhone();
            },
              child: Text("Send OTP"),
            ),
          ),

    Padding(
    padding: const EdgeInsets.all(30.0),
    child: PinPut(
    fieldsCount: 5,
    textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
    eachFieldWidth: 40.0,
    eachFieldHeight: 55.0,
    focusNode: _pinPutFocusNode,
    controller: _pinPutController,
    submittedFieldDecoration: pinPutDecoration,
    selectedFieldDecoration: pinPutDecoration,
    followingFieldDecoration: pinPutDecoration,
    pinAnimationType: PinAnimationType.fade,
    onSubmit: (pin) async {
      try{
    await FirebaseAuth.instance.signInWithCredential(
    PhoneAuthProvider.credential(verificationId: _verificationId, smsCode: pin))
        .then((value) async{
    if(value.user != null){
Navigator.pushAndRemoveUntil(context, MaterialPageRoute
(builder: (context)=>Home()), (route) => true) ;   }
    });
    } catch(e){
        FocusScope.of(context).unfocus();
        _scaffoldkey.currentState!.showSnackBar(SnackBar(content: Text("Invalid OTP")));
    }

    },
    ),
    ),
          RaisedButton(onPressed: (){
            
          },
          child: Text("Submit"),)
        ],
      ),

    );
  }

  verifyPhone() async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await _auth.FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      showSnackbar("Phone number automatically verified and user signed in: ${_auth.FirebaseAuth.instance.currentUser!.uid}");
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      showSnackbar('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
    };
    PhoneCodeSent codeSent =
        (String verificationId,int? forceResendingToken  ) async {
      showSnackbar('Please check your phone for the verification code.');
      _verificationId = verificationId;
    } as PhoneCodeSent;
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      showSnackbar("verification code: " + verificationId);
      _verificationId = verificationId;
    };

    try {
      await _auth.FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: _phoneNumber.text,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackbar("Failed to Verify Phone Number: ${e}");
    }
  }
  void showSnackbar(String message) {
    _scaffoldkey.currentState?.showSnackBar(SnackBar(content: Text(message)));
  }


  @override
  void initState(){
    super.initState();
    verifyPhone();
  }
}
