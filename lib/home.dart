import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:assets_audio_player/src/playable.dart';
import 'package:flutter/material.dart';
import 'package:music_tape/Pages/Refraction/nowplayingscreen.dart';
import 'package:music_tape/Pages/albums.dart';
import 'package:music_tape/Pages/favourites.dart';
import 'package:music_tape/Pages/mymusic..dart';
import 'package:music_tape/Pages/playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatefulWidget {
  List<Audio> allsongs;
  Home({Key? key, required this.allsongs}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final audioQuery = OnAudioQuery();
  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.withId('0');
  int _currentSelectedIndex = 0;
  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      MyMusic(
        fullsongs: widget.allsongs,
      ),
      Albums(),
      playlist(),
      Favourites(),
    ];
    return Scaffold(
      bottomSheet: GestureDetector(
        onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NowPlayingScreen(
                      index: 0,
                      allsongs: widget.allsongs,
                    )));
      }, child: SizedBox(
        height: 60,
        child: assetsAudioPlayer.builderCurrent(
            builder: (BuildContext context, Playing? playing) {
          final myAudio = find(widget.allsongs, playing!.audio.assetAudioPath);

          return Container(
            height: 80,
            color: Color.fromARGB(255, 218, 180, 236),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0), 
                        child: QueryArtworkWidget(
                            id: int.parse(myAudio.metas.id!),
                            artworkBorder: BorderRadius.circular(5.0),
                            type: ArtworkType.AUDIO),
                      ),
                    ),
                    Text(
                       myAudio.metas.artist!,
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                Wrap(
                  spacing: 15.0,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                   IconButton(
                        onPressed: () {
                          assetsAudioPlayer.previous();
                        },
                        icon: const Icon(Icons.skip_previous)
                      ),
                      PlayerBuilder.isPlaying(
                          player: assetsAudioPlayer,
                          builder: (context, isPlaying) {
                            return IconButton(
                              onPressed: () async {
                                await assetsAudioPlayer.playOrPause();
                              },
                              icon: Icon(
                                isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                              ),
                            );
                          }),
                      GestureDetector(
                        child: IconButton(
                          onPressed: () {
                            assetsAudioPlayer.next();
                          },
                          icon: const Icon(Icons.skip_next),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        }),
      )),
      body: _widgetOptions.elementAt(_currentSelectedIndex),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color.fromARGB(255, 214, 165, 236),
        ),
        child: BottomNavigationBar(
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.white,
            currentIndex: _currentSelectedIndex,
            onTap: (newIndex) {
              setState(() {
                _currentSelectedIndex = newIndex;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.headphones), label: 'My Music'),
              BottomNavigationBarItem(icon: Icon(Icons.album), label: 'Albums'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.playlist_add), label: 'Playlist'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_outlined), label: 'Favourite'),
            ]),
      ),
    );
  }
}
