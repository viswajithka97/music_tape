import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:assets_audio_player/src/playable.dart';
import 'package:flutter/material.dart';
import 'package:music_tape/Pages/Refraction/playlistlist.dart';
import 'package:music_tape/database/playlist_model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

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
  bool isPlaying = false;
  bool isLooping = false;
  bool isShuffle = false;
  Playlistmodel? music;
  final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  final box = Playlistbox.getInstance();
  List<Playlistmodel> dbSongs = [];
  List<dynamic>? likedSongs = [];
  @override
  Widget build(BuildContext context) {
    dbSongs = box.get("musics") as List<Playlistmodel>;

    List? favourites = box.get("favourites");

    //final temp = databaseSongs(dbSongs, songId);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 214, 165, 236),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Now Playing',
          style: TextStyle(fontSize: 25, color: Colors.black),
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
                color: Colors.black,
              ))
        ],
      ),
      body: player.builderCurrent(builder: (context, Playing? playing) {
        final myAudio = find(widget.fullSongs, playing!.audio.assetAudioPath);
        final currentSong = dbSongs.firstWhere(
            (element) => element.id.toString() == myAudio.metas.id.toString());

        likedSongs = box.get("favourites");

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
                      height: 400,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)),
                      child: QueryArtworkWidget(
                          id: int.parse(myAudio.metas.id!),
                          artworkBorder: BorderRadius.circular(5.0),
                             nullArtworkWidget: Icon(Icons.music_note_outlined,size: 50,),
                          type: ArtworkType.AUDIO),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    player.builderRealtimePlayingInfos(
                        builder: (context, RealtimePlayingInfos infos) {
                      return ProgressBar(
                          onSeek: (slide) {
                            player.seek(slide);
                          },
                          timeLabelPadding: 15,
                          progressBarColor: Color.fromARGB(255, 137, 59, 211),
                          baseBarColor: Color.fromARGB(255, 180, 174, 174),
                          barHeight: 10,
                          thumbRadius: 0,
                          thumbColor: Colors.white,
                          timeLabelTextStyle:
                              TextStyle(color: Colors.black, fontSize: 17),
                          progress: infos.currentPosition,
                          total: infos.duration);
                    }),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StatefulBuilder(
                          builder: (BuildContext context,
                              void Function(void Function()) setState) {
                            return likedSongs!
                                    .where((element) =>
                                        element.id.toString() ==
                                        currentSong.id.toString())
                                    .isEmpty
                                ? IconButton(
                                    onPressed: () async {
                                      likedSongs?.add(currentSong);
                                      box.put("favourites", likedSongs!);
                                      likedSongs = box.get("favourites");
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                      Icons.favorite_border,
                                      size: 35,
                                    ),
                                  )
                                : IconButton(
                                    onPressed: () async {
                                      setState(() {
                                        likedSongs?.removeWhere((elemet) =>
                                            elemet.id.toString() ==
                                            currentSong.id.toString());
                                        box.put("favourites", likedSongs!);
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.favorite,color: Color.fromARGB(255, 189, 69, 61),
                                      size: 35,
                                    ),
                                  );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StatefulBuilder(
                    builder: (BuildContext context,
                        void Function(void Function()) setState) {
                      return !isShuffle
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  isShuffle = true;
                                  player.toggleShuffle();
                                });
                              },
                              icon: const Icon(
                                Icons.shuffle,
                                size: 35,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  isShuffle = false;
                                  player.setLoopMode(LoopMode.playlist);
                                });
                              },
                              icon: const Icon(
                                Icons.cached,
                                size: 35,
                              ),
                            );
                    },
                  ),
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
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              size: 50,
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
                  StatefulBuilder(
                    builder: (BuildContext context,
                        void Function(void Function()) setState) {
                      return !isLooping
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  isLooping = true;
                                  player.setLoopMode(
                                    LoopMode.single,
                                  );
                                });
                              },
                              icon: const Icon(
                                Icons.repeat,
                                size: 35,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  isLooping = false;
                                  player.setLoopMode(LoopMode.playlist);
                                });
                              },
                              icon: const Icon(
                                Icons.repeat_one,
                                size: 35,
                              ),
                            );
                    },
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
  // Playlistmodel databaseSongs(List<Playlistmodel> songs, String id) {
  //   return songs.firstWhere(
  //     (element) => element.songurl.toString().contains(id),
  //   );
  // }
}
