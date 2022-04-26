import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_tape/player/nowplayingscreen.dart';
import 'package:music_tape/Pages/Refraction/popupmenu.dart';
import 'package:music_tape/player/openplayer.dart';
import 'package:music_tape/Database/playlist_model.dart';
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
      appBar: AppBar(
        title: Text(widget.playlistName),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                          height: double.infinity,
                          color: Colors.green,
                          child: Text('data'));
                    });
              },
              icon: Icon(Icons.add))
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
                        ? Container(
                            height: 30,
                            width: 60,
                            child: Center(
                              child: Text('Add Some Songs'),
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
                                              color: Color.fromARGB(
                                                  255, 227, 194, 233)),
                                          child: ListTile(
                                            // onTap: (() async {
                                            //   await OpenPlayer(fullSongs: [], index: index)
                                            //       .openAssetPlayer(
                                            //     index: index,
                                            //     songs: widget.,
                                            //   );
                                            // }),
                                            leading: QueryArtworkWidget(
                                                id: playlistSongs[index].id!,
                                                artworkBorder:
                                                    BorderRadius.circular(5.0),
                                                type: ArtworkType.AUDIO),
                                            title: Text(
                                                playlistSongs[index].songname!),
                                            subtitle: Text(
                                                playlistSongs[index].artist!),
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
                            for (var element in playlistSongs) {
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
                            OpenPlayer(fullSongs: playPlaylist, index: index)
                                .openAssetPlayer(
                                    index: index, songs: playPlaylist);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NowPlayingScreen(
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
