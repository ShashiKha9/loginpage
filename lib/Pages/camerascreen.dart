

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';



class CameraScreen extends StatefulWidget{



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
    
    Fluttertoast.showToast(msg: "Video posted sucessfully ",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Center(
  child:


    RaisedButton(
      color: Colors.red[400],
      onPressed: () {
      recvideo();
    },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(140)),
        padding: EdgeInsets.all(30),
      child: Icon(CupertinoIcons.camera_fill)),
   



    )

    );
  }




}
