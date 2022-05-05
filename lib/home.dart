import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:assets_audio_player/src/playable.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:music_tape/Pages/Refraction/drawer.dart';
import 'package:music_tape/player/nowplayingscreen.dart';
import 'package:music_tape/Pages/albums.dart';
import 'package:music_tape/Pages/favourites.dart';
import 'package:music_tape/Pages/mymusic..dart';

import 'package:music_tape/playlistpage.dart';
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
      Albums(
         fullsongs: widget.allsongs,
      ),
      PlaylistPage(),
      Favourites(),
    ];
    return Scaffold(
      drawer: drawer(),
      bottomSheet: GestureDetector(
        onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NowPlayingScreen(
                      index: 0,
                      fullSongs: widget.allsongs,
                    )));
      }, child: assetsAudioPlayer.builderCurrent(
          builder: (BuildContext context, Playing? playing) {
        final myAudio = find(widget.allsongs, playing!.audio.assetAudioPath);

        return Container(
          height: 80,
          color: Color.fromARGB(255, 218, 180, 236),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60,width: 60,
                    decoration: BoxDecoration(  borderRadius: BorderRadius.circular(5.0), ),
                      child: QueryArtworkWidget(
                           nullArtworkWidget: Icon(Icons.music_note_outlined,size: 50,),
                          id: int.parse(myAudio.metas.id!),
                          artworkBorder: BorderRadius.circular(5.0),
                          type: ArtworkType.AUDIO),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height:20,width: 180,
                        child: Marquee(
                          velocity: 20,
                          startAfter: Duration.zero,
                          blankSpace: 100,
                          text:
                             myAudio.metas.title!,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      SizedBox(height:20,width: 180,
                        child: Marquee(
                          
                          
                          startAfter: Duration.zero,
                          blankSpace: 150,
                          velocity: 20,
                          text:
                             myAudio.metas.artist!,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                    ],
                  ),
                    
                  
                ],
              ),
              SizedBox(width: 50,),
              Wrap(
                spacing: 15.0,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                 IconButton(
                      onPressed: () {
                        assetsAudioPlayer.previous();
                      },
                      icon: const Icon(Icons.skip_previous,size: 35,)
                    ),
                    PlayerBuilder.isPlaying(
                        player: assetsAudioPlayer,
                        builder: (context, isPlaying) {
                          return Container(
                            height: 50,width: 50,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.white),
                            child: IconButton(
                              onPressed: () async {
                                await assetsAudioPlayer.playOrPause();
                              },
                              icon: Icon(
                                isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,size: 35,
                              ),
                            ),
                          );
                        }),
                    GestureDetector(
                      child: IconButton(
                        onPressed: () {
                          assetsAudioPlayer.next();
                        },
                        icon: const Icon(Icons.skip_next,size: 35,),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      })),
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
