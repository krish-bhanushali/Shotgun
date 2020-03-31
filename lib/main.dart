import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

//next versions
// I will try to add an app icon and improve the UI and add timee in min,sec
//Add name of the song and image of it too
// try to add feature for the buttons that are not working
//as I learn routing I will allow user to get more songs and often create a list
//this only plays from the online link hence I will have functionality to play from the local file
//future goal to make it a fully fleshed app

void main() => runApp(MyApp());




class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  //initialized the player instance from the import
  AudioPlayer player = new AudioPlayer();
  //two Icon variable that will change their state , in bottom nav bar
  IconData iconName = Icons.play_circle_filled ;
  IconData favIcon = Icons.favorite_border;

  //to get the duration
  Duration duration;
  // for total time
  int time;
  //for time left
  String timeLeft = '';
  //for the progress bar
  double progress = 0.0;


  //to get the left time , now if duration is null , duration we will get in by author defined class method and set duration
  void getTimeLeft(){
    if(duration == null){
      setState(() {
        timeLeft = 'time left is 0s';
      });
    }
    else{
      setState(() {
        timeLeft = "time left ${duration.inSeconds} s";
      });
    }
  }

  //to get the progress
  void getProgress(){
    if(time == null || duration == null)
      {
        setState(() {
          progress = 0.0;
        });
      }
    else
      {
        setState(() {
          progress = time / (duration.inMilliseconds);
        });
      }
  }

 //to play music from the url
  void playMusic()
  {

    player.play('https://file-examples.com/wp-content/uploads/2017/11/file_example_MP3_700KB.mp3',stayAwake: true);
    setState(() {
      iconName = Icons.pause_circle_filled;
    });

  }

  //to pause the music
  void pauseMusic(){
    player.pause();
    setState(() {
      iconName = Icons.play_circle_filled;
    });
  }

  //to stop the music
  void stopMusic(){
    player.stop();
    setState(() {
      iconName = Icons.play_circle_filled;
    });
  }

  @override
  void initState() {

    // TODO: implement initState
    super.initState();

    // we pass the values to time and duration that we created from the values received by package or our player , they may also be called as listeners
    player.onAudioPositionChanged.listen((Duration p) async {
      time = await player.getDuration();
      duration = p;
      if (duration == null) {
        timeLeft = "Time Left 0s/0s";
      } else {
        timeLeft = "Time Left ${duration.inSeconds}s/${(time / (1000))}s";
      }
      if (time == null || duration == null) {
        progress = 0.0;
      } else {
        progress = (duration.inMilliseconds) / time;
      }
      print(progress);
      setState(() {});

   });}
    @override
    void dispose() async {
      await player.release();
      await player.dispose();
      super.dispose();
    }  

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('SHOTGUN')),
          backgroundColor: Colors.grey[850],
        ),
        backgroundColor: Colors.grey[900],
        body: Column(
               mainAxisAlignment: MainAxisAlignment.end,

               children: <Widget>[
                 Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: <Widget>[
                     SizedBox(
                       width: 60.0,
                     ),
                     Container(
                       child: Image.asset('images/pablo.png'),
                       height:200.0,
                       width: 200.0,
                       margin: EdgeInsets.only(left:46.0),
                       decoration: BoxDecoration(
                         color: Colors.grey[850],
                         shape: BoxShape.rectangle,
                         borderRadius: BorderRadius.circular(10.0),
                         boxShadow: <BoxShadow>[BoxShadow(
                           color: Colors.grey[700],
                           blurRadius: 10.0,
                           offset: Offset(0.0, 10.0,),

                         ),
                       BoxShadow(
                         color: Colors.grey[700],
                         blurRadius: 10.0,
                         offset: Offset(0.0, -10.0,)
                       )],
                       ),
                     ),
                   ],
                 ),
                 SizedBox(height: 40.0,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     Column(

                       children: <Widget>[
                         Text('I call SHOTGUN',style: TextStyle(color: Colors.grey[350],fontSize: 20.0),),
                         Text('By Krish Bhanushali',style: TextStyle(color: Colors.grey[350],fontSize: 10.0),)
                       ],
                     ),

                   ],
                 ),
                 SizedBox(
                   height: 200.0,
                 ),
                 Container(
                   width: 400.0,
                   padding: EdgeInsets.all(16.0),
                   child: LinearProgressIndicator(
                     backgroundColor: Colors.grey[850],
                     value: progress,
                     valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[350]),
                   ),
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: <Widget>[
                     Container(
                       margin: EdgeInsets.only(left:20.0),
//                         padding: EdgeInsets.all(16.0),
                         child: Text(timeLeft,style: TextStyle(color: Colors.grey[350]),),)
                   ],
                 ),
//reference commented code below
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     FloatingActionButton(
//                         onPressed:()
//                         { if(iconName == Icons.play_circle_filled){
//                           playMusic();
//                           }
//
//                           else if(iconName == Icons.pause_circle_filled){
//                           pauseMusic();
//                         }
//
//                         },
//                         backgroundColor: Colors.grey[850],
//                         child: Icon(iconName)),
//                     FlatButton(onPressed:()
//                         {stopMusic();},
//
//                          child: Icon(Icons.stop),
//                         )
//                   ],
//                 ),
//                 SizedBox(height: 50.0,)



        ],
      ),
        bottomNavigationBar: BottomAppBar(

          color: Colors.grey[900],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 100.0,
                child: FlatButton(onPressed:()
                {stopMusic();},

                  child: Icon(Icons.stop,color: Colors.grey[350],),
                )
              ),
              Container(
                child: FlatButton(onPressed: null, child: Icon(Icons.skip_previous,color: Colors.grey[350],)
                
                ),
              ),
              Container(
                child: FloatingActionButton(
                    onPressed:()
                    { if(iconName == Icons.play_circle_filled){
                      playMusic();
                    }

                    else if(iconName == Icons.pause_circle_filled){
                      pauseMusic();
                    }

                    },
                    backgroundColor: Colors.grey[850],
                    child: Icon(iconName)),
              ),
              Container(
                child: FlatButton(onPressed: null, child: Icon(Icons.skip_next,color: Colors.grey[350],)),
              ),
              Container(
                child: FlatButton(
                    onPressed: (){
                      if(favIcon == Icons.favorite_border){
                        setState(() {
                          favIcon = Icons.favorite;
                        });
                      }
                      else{
                        setState(() {
                          favIcon = Icons.favorite_border;
                        });
                      }
                    }
                    ,
                    child: Icon(favIcon,color: Colors.grey[350],),
              ),

              )],
          ),

        ),
    )
    );
  }
}


