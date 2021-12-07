import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart'as _auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginpage/Pages/viewvideo_screen.dart';
import 'package:loginpage/bloc/login_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
 enum MobileVerificationState{
  Show_Mobile_Form_State,
  Show_Otp_Form_State,


}

class OtpScreen extends StatefulWidget {
@override
  OtpScreenState createState() => OtpScreenState();
}
class OtpScreenState extends State<OtpScreen>{
   late String resend= "";
    int ?_forceResendingToken;

  MobileVerificationState currentState=MobileVerificationState.Show_Mobile_Form_State;
   late String dialCodeDigits = "+00";
  final  GlobalKey<ScaffoldState> _scaffoldkey =GlobalKey<ScaffoldState>();
   late String verificationId;
  static bool  showLoading= false;
   final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  FirebaseAuth _auth =FirebaseAuth.instance;
   String ? newLaunch;
   final loginbloc = LoginBloc();


   storeData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  setState(() {
    // _counter= (prefs.getInt("counter")??0);
    bool newLaunch = (prefs.getBool("newLaunch")?? true);
  });

}

@override
void initState(){
  super.initState();
  storeData();
}
   void _incrementCounter()  async {
     SharedPreferences prefs = await SharedPreferences.getInstance();

     setState(() {
       // prefs.setInt('counter', _counter);


     });
   }


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
       if(authCredential.user!= null){
         Navigator.push(context, MaterialPageRoute(builder: (context)=> PageScreen()));
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
    return Scaffold(
        backgroundColor: Color(0xff0f1316),
        body:   Column(
      children: [
        Image(image: NetworkImage("https://assets.turbologo.com/blog/en/2019/11/19084834/gaming-logo-cover.jpg")),
      Padding(padding: EdgeInsets.only(top: 90,left: 20,right: 20),
      child:Container(
      child:  TextField(
        style: TextStyle(color: Colors.white),
          controller: phoneNumberController,
          decoration: InputDecoration(
            hintText: "Phone Number",
            hintStyle: TextStyle(color: Colors.white54),
            suffixIcon: Icon(CupertinoIcons.phone,color: Colors.white54,),
          ),
        ),
        ),
        ),
        SizedBox(height: 22,),
        FlatButton(
          onPressed:() async{
          starttimer();
          setState(() {
            showLoading=true;
          });
         await _auth.verifyPhoneNumber(phoneNumber: "+91${phoneNumberController.text}",
              forceResendingToken: _forceResendingToken,


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
              codeSent: (verificationId,forceresendingToken)async{
            setState(() {
              currentState=MobileVerificationState.Show_Otp_Form_State;
              this.verificationId=verificationId;
              this._forceResendingToken=forceresendingToken;
              showLoading= false;
            });



              },
              codeAutoRetrievalTimeout: (verificationId)async {
                print("Time Out. Duration Exceeded");
                this.verificationId=verificationId;

              },
           timeout: Duration(milliseconds: 10000)




          );
         SharedPreferences prefs = await SharedPreferences.getInstance();
         prefs.setString("phoneNumber", phoneNumberController.text);

        },



child: Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(colors: [
      Color(0xff05f2b3),Colors.blue
    ]),
    borderRadius: BorderRadius.circular(20)

  ),
  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
  child: Text("Send",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w300),),

),
        ),
      ],
   )
    );

  }


  getOtpFormWidget(context){
     BlocBuilder(
       bloc: loginbloc,
         builder: (
     context,LoginState
     ){
           return Column(
             children: [
               Image(image: NetworkImage("https://assets.turbologo.com/blog/en/2019/11/19084834/gaming-logo-cover.jpg"),),
               Padding(padding: EdgeInsets.only(top: 90,left: 20,right: 20),
                 child: TextField(
                   style: TextStyle(color: Colors.white),
                   keyboardType: TextInputType.number,
                   controller: otpController,
                   decoration: InputDecoration(
                       hintText: "Enter OTP",
                       hintStyle: TextStyle(color: Colors.white54),
                       suffixIcon: Icon(CupertinoIcons.padlock,color: Colors.white54,)
                   ),
                 ),
               ),
               SizedBox(height: 16,),

               Wrap(
                   children: [
                     Text("Send OTP again in ",style: TextStyle(
                         fontSize: 14,color: Colors.white54
                     ),),
                     Text("00:$start ",style: TextStyle(
                         fontSize: 14,color: Colors.red
                     ),),
                     Text("sec ",style: TextStyle(
                         fontSize: 14,color: Colors.white54
                     ),),
                   ]
               ),
               SizedBox(
                 height: 10,
               ),


               RichText(text: TextSpan(
                   children: [
                     TextSpan(
                         text: "Did not get otp,",
                         style: TextStyle(fontSize: 14,color: Colors.white54)
                     ),
                     start==0 ?

                     TextSpan(
                         text: " resend?",
                         style: TextStyle(fontSize: 16,color: wait? Colors.grey:Colors.blue),
                         recognizer: TapGestureRecognizer()
                           ..onTap=wait ?null:() {
                             _auth.verifyPhoneNumber(phoneNumber: "+91${phoneNumberController.text}",
                                 forceResendingToken: _forceResendingToken,


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
                                 codeSent: (verificationId,forceresendingToken)async{
                                   setState(() {
                                     currentState=MobileVerificationState.Show_Otp_Form_State;
                                     this.verificationId=verificationId;
                                     this._forceResendingToken=forceresendingToken;
                                     showLoading= false;
                                   });



                                 },
                                 codeAutoRetrievalTimeout: (verificationId)async {
                                   print("Time Out. Duration Exceeded");
                                   this.verificationId=verificationId;

                                 },
                                 timeout: Duration(milliseconds: 10000)




                             );      setState(() {
                               starttimer();
                               start=30;
                               wait= true;
                             });

                             print("judnu");
                             PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
                               verificationId: verificationId, smsCode: otpController.text,);
                             signInWithPhoneAuthCredential(phoneAuthCredential);
                           }


                     ):
                     TextSpan(
                         text: " resend?",
                         style: TextStyle(fontSize: 16,color: Colors.grey)
                     ),
                   ]
               )),
               SizedBox(
                 height: 22,
               ),
               FlatButton(onPressed: () {
                 PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
                   verificationId: verificationId, smsCode: otpController.text,);
                 signInWithPhoneAuthCredential(phoneAuthCredential);
               }
                 , child: Container(
                   decoration: BoxDecoration(
                       gradient: LinearGradient(colors: [
                         Color(0xff05f2b3),Colors.blue
                       ]),
                       borderRadius: BorderRadius.circular(20)

                   ),
                   padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                   child: Text("Get Started",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w300),),

                 ),
               ),
             ],





           );
         });



  }


int start= 30;
   bool wait = false;
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (_)=> LoginBloc(),
    
     child: MaterialApp(
home:      Scaffold(
      backgroundColor: Color(0xff03fccf),
        body: Container(
          child:ClipPath(
            clipper: MyClipper(),
            child: showLoading ? Center(
          child: CircularProgressIndicator(),
        ) :currentState==MobileVerificationState.Show_Mobile_Form_State
       ? getMobileFormWidget(context)
            : getOtpFormWidget(context),
      ),



        )
)
)
    );

}
void dispose(){
    super.dispose();
}
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height-120);
    // path.lineTo(size.width, size.height / 1.5);
    // path.lineTo(size.width, 0.0);
    var cp = Offset(120,size.height );
    var ep = Offset(size.width,size.height/2);
    path.quadraticBezierTo(cp.dx,cp.dy,ep.dx,ep.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    // path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper)=> false;


  

}


