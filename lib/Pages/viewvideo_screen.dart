import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      autoPlay: true,
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
class VideoList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Text("Explore",style: TextStyle(fontSize: 16),) ,
            label: ""
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.add,size: 25,),
            label: ""
          )
        ],
      ),

body:
    Column(
      children:[
Container(
  height: 300,
  child:
  ViewVideoScreen(
  videoPlayerController: VideoPlayerController.network(
  "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"
  ), looping: true,


),





),
  

        ]
    )
    );
  }
}