import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:assets_audio_player/src/playable.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class NowPlayingScreen extends StatefulWidget {
  int index;
  List<Audio> fullSongs = [];
  NowPlayingScreen({
    Key? key,
    required this.index,
    required this.fullSongs,

  }) : super(key: key);
 
  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
   final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 214, 165, 236),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Now Playing',
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 30,
              ))
        ],
      ),
      body: player.builderCurrent(builder: (context, Playing? playing) {
        final myAudio = find(widget.fullSongs, playing!.audio.assetAudioPath);
        return Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                      Container(
                        height: 400,width:double.infinity,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                        child: QueryArtworkWidget(
                          id: int.parse(myAudio.metas.id!),
                    artworkBorder: BorderRadius.circular(5.0),
                     type: ArtworkType.AUDIO),
                      ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.tune,
                          size: 35,
                        ),
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 35,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    LinearPercentIndicator(
                      lineHeight: 10,
                      percent: 0.4,
                      barRadius: const Radius.circular(16),
                      progressColor: Color.fromARGB(255, 179, 31, 147),
                      backgroundColor: Colors.grey[300],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '1.35',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          '4.35',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.shuffle, size: 35)),
                  IconButton(
                      onPressed: () {
                        player.previous();
                      },
                      icon: Icon(Icons.skip_previous,
                          size: 40, color: Colors.white)),
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.white),
                    child: PlayerBuilder.isPlaying(
                          player: player,
                          builder: (context, isPlaying) {
                            return IconButton(
                              onPressed: () async {
                                await player.playOrPause();
                              },
                              icon: Icon(
                                isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,size: 50,
                              ),
                            );
                          }),
                  ),
                  IconButton(
                      onPressed: () {
                        player.next();
                      },
                      icon:
                          Icon(Icons.skip_next, size: 40, color: Colors.white)),

                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.playlist_add,
                        size: 35,
                      )),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
