import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_tape/Pages/Refraction/playlistscreenaddsongs.dart';
import 'package:music_tape/database/playlist_model.dart';
import 'package:music_tape/player/nowplayingscreen.dart';
import 'package:music_tape/player/openplayer.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistScreen extends StatefulWidget {
  String playlistName;
  PlaylistScreen({Key? key, required this.playlistName}) : super(key: key);

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final box = Playlistbox.getInstance();

  List<PlaylistModel>? dbSongs = [];
  List<PlaylistModel>? playlistSongs = [];
  List<Audio> playPlaylist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 214, 165, 236),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.playlistName,
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              padding: const EdgeInsets.only(right: 20),
              onPressed: () {
                showModalBottomSheet(
                    backgroundColor: const Color.fromARGB(255, 214, 165, 236),
                    context: context,
                    builder: (context) {
                      return SongSheet(
                        playlistName: widget.playlistName,
                      );
                    });
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
                size: 30,
              ))
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: ValueListenableBuilder(
                  valueListenable: box.listenable(),
                  builder: (context, value, child) {
                    var playlistSongs = box.get(widget.playlistName)!;
                    return playlistSongs.isEmpty
                        ? Center(
                            child: Container(
                              height: 50,
                              width: 100,
                              child: const Text(
                                'Add Some Songs',
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: playlistSongs.length,
                            itemBuilder: (context, index) => GestureDetector(
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 10.0, right: 10.0),
                                      child: Container(
                                          height: 75,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: const Color.fromARGB(
                                                  255, 227, 194, 233)),
                                          child: ListTile(
                                            leading: QueryArtworkWidget(
                                                id: playlistSongs[index].id,
                                                artworkBorder:
                                                    BorderRadius.circular(5.0),
                                                type: ArtworkType.AUDIO),
                                            title: Text(
                                                playlistSongs[index].songname),
                                            subtitle: Text(
                                                playlistSongs[index].artist),
                                            trailing: PopupMenuButton(
                                              itemBuilder:
                                                  (BuildContext context) => [
                                                const PopupMenuItem(
                                                  value: "1",
                                                  child: Text(
                                                    "Remove song",
                                                  ),
                                                ),
                                              ],
                                              onSelected: (value) {
                                                if (value == "1") {
                                                  setState(() {
                                                    playlistSongs
                                                        .removeAt(index);
                                                    box.put(widget.playlistName,
                                                        playlistSongs);
                                                  });
                                                }
                                              },
                                            ),
                                            onTap: () {
                                              for (var element
                                                  in playlistSongs) {
                                                playPlaylist.add(
                                                  Audio.file(
                                                    element.songurl!,
                                                    metas: Metas(
                                                      title: element.songname,
                                                      id: element.id.toString(),
                                                      artist: element.artist,
                                                    ),
                                                  ),
                                                );
                                              }
                                              OpenPlayer(
                                                      fullSongs: playPlaylist,
                                                      index: index)
                                                  .openAssetPlayer(
                                                      index: index,
                                                      songs: playPlaylist);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      NowPlayingScreen(
                                                    fullSongs: playPlaylist,
                                                    index: index,
                                                  ),
                                                ),
                                              );
                                            },
                                          ))),
                                ));
                  }))
        ],
      )),
    );
  }
}
