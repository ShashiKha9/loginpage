import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget{


  CameraDescription? camera;

  CameraScreenState createState()=> CameraScreenState();


}
class CameraScreenState extends State<CameraScreen>{
  CameraController ?controller;

  @override
  void initState(){
    super.initState();
    controller=CameraController(widget.camera!, ResolutionPreset.max);
    controller!.initialize().then((_)  {
      if(!mounted){
        return;
      }
      setState(() {

      });


    });
  }
  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if (!controller!.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: CameraPreview(controller!),
    );
  }
}