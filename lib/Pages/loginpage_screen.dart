
import 'package:flutter/material.dart';
import 'package:loginpage/Pages/otp_screen.dart';

class LoginPageScreen extends StatelessWidget{
 final emailcontroller = TextEditingController();
 final passwordlcontroller = TextEditingController();
 final otpcontroller = TextEditingController();


 @override
  Widget build(BuildContext context) {
return SafeArea(
  child:Scaffold(
  body: Column(
    children: [
      Padding(padding: EdgeInsets.only(top: 30),
     child: Text("Login",style: TextStyle(
        fontSize: 22,fontWeight: FontWeight.w700,),),
      ),
      TextFormField(
        
        keyboardType: TextInputType.emailAddress,
        controller: emailcontroller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(20),
            hintText: "Enter your email",
          prefixIcon: Icon(Icons.email,color: Colors.black,)
            
        ),

          
        


      ),
      TextFormField(
        obscureText: true,
        validator: (value){
          if(value!.isEmpty){
            return "please enter your password";
          }
        },

        keyboardType: TextInputType.visiblePassword,
        controller: otpcontroller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(20),
            hintText: "Enter your password",
            prefixIcon: Icon(Icons.lock,color: Colors.black,)

        ),






      ),
      // RaisedButton(onPressed: (){
      //   Navigator.of(context).push(MaterialPageRoute(
      //       builder: (context)=> OtpScreen(otpcontroller.text)));
      //
      //
      // },
      // child: Text("Login"),)

    ],
  ),
  )
) ;
  }
}