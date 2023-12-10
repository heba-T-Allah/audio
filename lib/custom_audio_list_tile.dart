import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class CustomAudioListTile extends StatefulWidget {
  bool isPlaying;
  int selectedIndex;
  int currentIndex;
  AssetsAudioPlayer assetsAudioPlayer;
  List<String> audios;

  CustomAudioListTile(
      {super.key,
      required this.isPlaying,
      required this.selectedIndex,
      required this.currentIndex,
      required this.assetsAudioPlayer,
      required this.audios});

  @override
  State<CustomAudioListTile> createState() => _CustomAudioListTileState(isPlaying,selectedIndex,currentIndex,assetsAudioPlayer,audios);
}

class _CustomAudioListTileState extends State<CustomAudioListTile> {
  bool isPlaying;
  int selectedIndex;
  int currentIndex;
  AssetsAudioPlayer assetsAudioPlayer;
  List<String> audios;
  _CustomAudioListTileState(this.isPlaying, this.selectedIndex,
      this.currentIndex, this.assetsAudioPlayer, this.audios);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: IconButton(
        onPressed: () {
          setState(() {
            isPlaying = !isPlaying;
            selectedIndex = currentIndex;
            print("----------------------selected index= $selectedIndex");

            if (assetsAudioPlayer.isPlaying.value) {
              assetsAudioPlayer.pause();
            } else {
              // assetsAudioPlayer.play()
              assetsAudioPlayer.playlistPlayAtIndex(currentIndex); // isPlaying=true;
            }
          });
        },
        icon: isPlaying && selectedIndex == currentIndex
            ? Icon(
                Icons.pause,
              )
            : Icon(
                Icons.play_arrow,
              ),
      ),
      title: Text("${audios[currentIndex]}"),
    );
  }
}
