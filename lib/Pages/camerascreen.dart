

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';



class CameraScreen extends StatefulWidget{

   CameraDescription? camera;


  CameraScreenState createState()=> CameraScreenState();


}
class CameraScreenState extends State<CameraScreen>{

    File ? videoFile;
    // String ? _videopath;
    File ?_storedImage;
    String ? dirPath;


    // CameraController? controller;
  //  List<CameraDescription>? cameras;
  // late Future<void> _initializeControllerFuture;



//   @override
//   void initState(){
//     super.initState();
//     Loadimage();
// //     controller=CameraController(cameras![0], ResolutionPreset.max);
// // _initializeControllerFuture=controller.initialize();

  // }
  // @override
  // void dispose() {
  //   controller!.dispose();
  //   super.dispose();
  // }


    recvideo() async{
      final pickedFile = await ImagePicker().getVideo(
        source: ImageSource.camera,
      );

      if(pickedFile!= null){
        setState(()  {
          videoFile=File(pickedFile.path);
          // _storedImage == imagePermanent;

  });
        videoFile=File(pickedFile!.path);
        final imagePermanent = await saveImagePermanently(pickedFile!.path);



      }
      // final directory= await getExternalStorageDirectory();
      // final String path = directory!.path;
      // // this._fileName  = path;
      // final File localImage = await videoFile!.copy(path);



    }
  Future saveImagePermanently(String imagePath) async{

        final directory = await getExternalStorageDirectory();
      final name = basename(imagePath);
      final image = "${directory!.path}/fluttervideos";
      final myImgDir = await new Directory(image).create();
        var kompresimg = new File("$image/image_.mp4")
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

    return Column(
    children:[
    // Container(
    //     height: 250,
    //     child: _videopath!=null
    //         ?Center(
    //       child:Container(
    //         color: Colors.blue,
    //       ),
    //
    //     ):Container(
    //       height: 250,
    //       child: Chewie(
    //           controller: ChewieController(
    //             videoPlayerController: VideoPlayerController.file(videoFile!),
    //             aspectRatio: 16/9,
    //             autoPlay: false,
    //             looping: true,
    //           ))
    //       ,
    //     ),
    // ),

    //   Container(
    //     height: 250,
    //     child:videoFile == null?Center(
    //       child:Container(
    //         color: Colors.red,
    //       ),
    //
    //     ):Container(
    //       height: 250,
    //       child: Chewie(
    //           controller: ChewieController(
    //             videoPlayerController: VideoPlayerController.file(videoFile!),
    //             aspectRatio: 16/9,
    //             autoPlay: false,
    //             looping: true,
    //           ))
    //       ,
    //     ),
    // ),



       SizedBox(
         height: 200,
       ),
       RaisedButton(onPressed: (){
recvideo();
        
      },
      child: Text("Rec"),),
      RaisedButton(onPressed: (){
        // Saveimage(videoFile!.path);
      },
      child: Text("Save"),)
      
]
    );
  }
}