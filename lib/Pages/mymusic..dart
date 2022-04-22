import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:assets_audio_player/src/playable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:music_tape/Pages/Refraction/drawer.dart';

import 'package:music_tape/Pages/openplayer.dart';
import 'package:music_tape/Pages/playlist.dart';

import 'package:on_audio_query/on_audio_query.dart';

class MyMusic extends StatefulWidget {
  List<Audio> fullsongs;
  MyMusic({
    Key? key,
    required this.fullsongs,
  }) : super(key: key);

  List<SongModel> songs = [];
  @override
  State<MyMusic> createState() => _MyMusicState();
}

class _MyMusicState extends State<MyMusic> {
  final AssetsAudioPlayer _player = AssetsAudioPlayer();

  final OnAudioQuery _audioQuery = OnAudioQuery();

  List<SongModel> songs = [];

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.withId('0');

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 214, 165, 236),
      drawer: drawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black, size: 35),
        title: Text(
          'Music Tape',
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          )
        ],
      ),
      body: FutureBuilder<List<SongModel>>(
        future: _audioQuery.querySongs(
            sortType: null,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true),
        builder: (context, item) {
          if (item.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (item.data!.isEmpty) {
            return Center(child: Text('No Songs Found'));
          }
          return ListView.builder(
            itemBuilder: (context, index) => Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Container(
                height: 75,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(255, 227, 194, 233)),
                child: ListTile(
                  onTap: (() async {
                    await OpenPlayer(fullSongs: [], index: index)
                        .openAssetPlayer(
                      index: index,
                      songs: widget.fullsongs,
                    );
                  }),
                  leading: QueryArtworkWidget(
                      id: item.data![index].id,
                      artworkBorder: BorderRadius.circular(5.0),
                      type: ArtworkType.AUDIO),
                  title: Text(item.data![index].displayNameWOExt),
                  subtitle: Text('${item.data![index].artist}'),
                  trailing: PopupMenuButton(
                    icon: Icon(Icons
                        .more_vert_outlined), //don't specify icon if you want 3 dot menu
                    // color: Colors.blue,
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: () {},
                        value: 0,
                        child: Text(
                          "Add to Playlist",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const PopupMenuItem(
                        value: 1,
                        child: Text(
                          "Add to Favourites",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                    onSelected: (item) => {
                      if (item == 0)
                        {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Playlist'),
                                  content: Container(
                                      height: 400,
                                      width: double.minPositive,
                                      child: Column(
                                        children: [
                                          ListTile(
                                            leading: Icon(
                                              Icons.add,
                                              color: Colors.blue,
                                            ),
                                            title: Text(
                                              'Create New Playlist',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title:
                                                          Text('Playlist Name'),
                                                      content: TextFormField(),
                                                      actions: [
                                                        Row(
                                                          mainAxisAlignment:
                                                          
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                    'Cancel')),
                                                            TextButton(
                                                                onPressed:
                                                                    () {},
                                                                child: Text(
                                                                    'Save')),
                                                          ],
                                                        )
                                                      ],
                                                    );
                                                  });
                                            },
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                                itemCount: 30,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    leading: Icon(
                                                        Icons.playlist_add),
                                                    title: Text('My Playlist'),
                                                    onTap: () {},
                                                  );
                                                }),
                                          ),
                                        ],
                                      )),
                                );
                              })
                        }
                    },
                  ),
                ),
              ),
            ),
            itemCount: item.data!.length,
          );
        },
      ),
    );
  }

  void addplaylist() {
    // PlaylistModel()
  }
}
