import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Audio player',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isPlaying = false;
  final assetsAudioPlayer = AssetsAudioPlayer();
  String path = "assets/sounds/";
  int selectedIndex = -1;
  final List<String> audios = <String>[
    "sample.mp3",
    "sample1.mp3",
    "sample2.mp3",
    "sample3.wav",
    "sample4.wav"
  ];

  @override
  void initState() {
    assetsAudioPlayer.open(
      Playlist(audios: [
        Audio("assets/sounds/sample.mp3"),
        Audio("assets/sounds/sample1.mp3"),
        Audio("assets/sounds/sample2.mp3"),
        Audio("assets/sounds/sample3.wav"),
        Audio("assets/sounds/sample4.wav"),
      ]),
      autoStart: false,
      loopMode: LoopMode.none,
    );
    // assetsAudioPlayer.playlistFinished.listen((event) {
    //   onFinished();
    //   print("----------------------finished");
    // });
    super.initState();
  }

  // void onFinished() {
  //   setState(() {
  //     // isPlaying = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Audio player"),
      ),
      body: ListView.builder(
        itemCount: audios.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    isPlaying = !isPlaying;
                    selectedIndex = index;
                    print(
                        "----------------------selected index= $selectedIndex");

                    if (assetsAudioPlayer.isPlaying.value) {
                      assetsAudioPlayer.pause();
                    } else {
                      // assetsAudioPlayer.play()
                      assetsAudioPlayer
                          .playlistPlayAtIndex(index); // isPlaying=true;
                    }
                  });
                },
                icon: isPlaying && selectedIndex == index
                    ? Icon(
                        Icons.pause,
                      )
                    : Icon(
                        Icons.play_arrow,
                      ),
              ),
              title: Text("${audios[index]}"),
            ),

            //costum list tile but set state should be here not in the other class
            // CustomAudioListTile(
            //   isPlaying: isPlaying,
            //   currentIndex: index,
            //   selectedIndex: index,
            //   assetsAudioPlayer: assetsAudioPlayer,
            //   audios: audios,),
          );
        },
      ),
    );
  }
}
