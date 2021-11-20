

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class CameraScreen extends StatefulWidget{

   CameraDescription? camera;


  CameraScreenState createState()=> CameraScreenState();


}
class CameraScreenState extends State<CameraScreen>{

  late File videoFile;

  late CameraController controller;
  //  List<CameraDescription>? cameras;
  // late Future<void> _initializeControllerFuture;


  @override
  void initState(){
    super.initState();
//     controller=CameraController(cameras![0], ResolutionPreset.max);
// _initializeControllerFuture=controller.initialize();

  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

    recvideo() async{
      PickedFile? pickedFile = await ImagePicker().getVideo(
        source: ImageSource.camera,
      );
      if(pickedFile!= null){
  setState(() {
  });
}
  }


  @override
  Widget build(BuildContext context) {

    return Container(
      child: RaisedButton(onPressed: (){
recvideo();
        
      },
      child: Text("Rec"),),
      

    );
  }
}