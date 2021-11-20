import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/Pages/camerascreen.dart';
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
class VideoList extends StatelessWidget{
   File? videoFile;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:Container(
        height: 250,
          child:videoFile == null?Center(


          ):Container(
            height: 250,
            child: Chewie(
                controller: ChewieController(
                  videoPlayerController: VideoPlayerController.file(videoFile!),
                  aspectRatio: 16/9,
                  autoPlay: false,
                  looping: true,
                )),
          )
      )
    );
  }
}
