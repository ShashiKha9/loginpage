

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginpage/Pages/homepgae_screen.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';



class CameraScreen extends StatefulWidget{

   CameraDescription? camera;


  CameraScreenState createState()=> CameraScreenState();


}
class CameraScreenState extends State<CameraScreen> {

  File ? videoFile;
  File ?_storedImage;
  String timestamp = new DateTime.now().toString();
  final Directory _videoDir = Directory(
      '/storage/emulated/0/Android/data/com.example.loginpage/files/fluttervideos');


  recvideo() async {
    final pickedFile = await ImagePicker().getVideo(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      setState(() {
        videoFile = File(pickedFile.path);
        // _storedImage == imagePermanent;

      });
      videoFile = File(pickedFile!.path);
      final imagePermanent = await saveImagePermanently(pickedFile!.path);
    }
  }

  Future saveImagePermanently(String imagePath) async {
    final directory = await getExternalStorageDirectory();
    final name = basename(imagePath);
    final image = "${directory!.path}/fluttervideos";
    final myImgDir = await new Directory(image).create();
    var kompresimg = new File(image+"/"+timestamp+"_video.mp4")
      ..writeAsBytesSync(videoFile!.readAsBytesSync());

    // var filepath = new File("$image");
    // var newFile = await filepath.writeAsBytesSync(/*image bytes*/);
    // await newFile.create();
    // ..writeAsBytesSync();


    // return filepath;
    //
    //
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Center(
   child: Column(
    children:[


    RaisedButton(onPressed: () {
      recvideo();
    },
      padding: EdgeInsets.all(70),
      child: Text("Rec"),),
   
]


    )
    )
    );
  }




}
