import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginpage/Pages/camerascreen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';


class ViewVideoScreen extends StatefulWidget{
  final VideoPlayerController videoPlayerController;
  final bool looping;
  ViewVideoScreen({
    required this.videoPlayerController,
    required this.looping,

});
  ViewVideoScreenState createState()=> ViewVideoScreenState();
}

class ViewVideoScreenState extends State<ViewVideoScreen>{
      ChewieController ? _chewieController;


      @override
  void initState() {
    super.initState();
       _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      autoPlay: false,
      looping: widget.looping,
        errorBuilder: (context,errorMessage){
        return Center(
          child: Text(errorMessage),

        );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(padding: EdgeInsets.all(8.0),
          child: Chewie(
            controller:_chewieController!,
          ),


        ),
      ),



    );
  }
  @override
  void dispose() {
    widget.videoPlayerController.dispose();
    _chewieController!.dispose();
    super.dispose();
  }

}
class PageScreen extends StatefulWidget{
  PageScreenState createState()=> PageScreenState();
}
class PageScreenState extends State <PageScreen>{
  int selectedindex = 0;
  PageController pageController = PageController();

  void onTapped(int index){
    setState(() {
      selectedindex=index;
    });
    pageController.jumpToPage(index);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
     body:
      PageView(
        controller: pageController,
        children: [
          Container(
            child: VideoList(),
          ),
          Container(
            child: CameraScreen()
            ,
          )
        ],

      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex: selectedindex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,

        items: [
          BottomNavigationBarItem(
              icon: Text("Explore",style: TextStyle(fontSize: 16),) ,

              label: ""
          ),

          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.add,size: 25,),
            label: "",

          ),

        ],

      ),






    );
  }

}
class VideoList extends StatefulWidget{
  VideoListState createState()=> VideoListState();
}
class VideoListState extends State<VideoList>{
   File? videoFile;
   recvideo() async{
     final pickedFile = await ImagePicker().getVideo(
       source: ImageSource.camera,
     );
     if(pickedFile!= null){
       setState(() async {
         videoFile=File(pickedFile.path) ;





       });
     }
   }
   Future<File?>pickVideoFile() async {
     final result = await FilePicker.platform.pickFiles(type: FileType.video);
     if(result == null) return null;

     return File(result.files.single.path!);


   }
   ChewieController ? _chewieController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:Container(
        height: 250,
          child:videoFile == null?Center(
            child:Container(
              color: Colors.red,
            ),


          ):FittedBox(
            fit: BoxFit.contain,
            child: Chewie(
                controller: ChewieController(
                  videoPlayerController: VideoPlayerController.asset("efueijt"),
                  aspectRatio: 16/9,
                  autoPlay: false,
                  looping: false,
                )),
          )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(CupertinoIcons.arrow_down_doc_fill),
        onPressed: () async {
final file = await pickVideoFile();
if(file == null) return;
Chewie(
    controller: ChewieController(
      videoPlayerController: VideoPlayerController.file(file),
      aspectRatio: 16/9,
      autoPlay: false,
      looping: false,
    ));

      },

      ),
    );
  }
}
