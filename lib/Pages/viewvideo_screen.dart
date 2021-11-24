import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:loginpage/Pages/camerascreen.dart';
import 'package:video_player/video_player.dart';



class ViewVideoScreen extends StatefulWidget{
  final VideoPlayerController videoPlayerController;
  final bool looping;
  ViewVideoScreen({
    required this.videoPlayerController,
    required this.looping,
    required Key key,

}) :super(key:key);
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
      appBar: AppBar(
        title: Text("Library"),
      ),
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

  final Directory _videoDir = Directory(
      '/storage/emulated/0/Android/data/com.example.loginpage/files/fluttervideos');


  @override
  Widget build(BuildContext context) {
    if (!Directory("${_videoDir.path}").existsSync()) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Record the videos +'),
        ],
      );
    }
    else {
      final videoList = _videoDir
          .listSync()
          .map((item) => item.path)
          .where((item) => item.endsWith(".mp4"))
          .toList(growable: false);
      if (videoList != null) {
        if (videoList.length > 0) {
          return
          Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 8.0),
              child: ListView.builder(
                itemCount: videoList.length,
                itemBuilder: (context, index) {
                  return
                    Container(
                    height: 250,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      ),
                      
                      child: Chewie(controller: ChewieController(
                          videoPlayerController: VideoPlayerController.file(File(videoList[index]),


                          ),

                      )),



                    ),
                  );



                },


              ),





            );

        }
      }

    }
    return Container();



  }





  }

