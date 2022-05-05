import 'package:flutter/material.dart';

import 'package:music_tape/Pages/createplaylist.dart';
import 'package:music_tape/database/playlist_model.dart';

class PlaylistList extends StatelessWidget {
  PlaylistList({Key? key, required this.song}) : super(key: key);
  Playlistmodel song;
  List playlists = [];
  List<dynamic>? playlistSongs = [];
  @override
  Widget build(BuildContext context) {
    final box = Playlistbox.getInstance();
    playlists = box.keys.toList();
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
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  showDialog(
                      context: context, builder: (context) => createPlaylist());
                },
              ),
              ...playlists
                  .map(
                    (audio) => audio != "musics" && audio != "favourites"
                        ? ListTile(
                            onTap: () async {
                              playlistSongs = box.get(audio);
                              List existingSongs = [];
                              existingSongs = playlistSongs!
                                  .where((element) =>
                                      element.id.toString() ==
                                      song.id.toString())
                                  .toList();
                              if (existingSongs.isEmpty) {
                                final songs =
                                    box.get("musics") as List<Playlistmodel>;
                                final temp = songs.firstWhere((element) =>
                                    element.id.toString() ==
                                    song.id.toString());
                                playlistSongs?.add(temp);

                                await box.put(audio, playlistSongs!);

                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    song.songname! + ' Added to Playlist',
                                  ),
                                ));
                              } else {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      song.songname! +
                                          ' is already in Playlist.',
                                    ),
                                  ),
                                );
                              }
                            },
                            leading: const Icon(Icons.queue_music),
                            title: Text(
                              audio.toString(),
                              style: const TextStyle(
                                fontSize: 22,
                              ),
                            ),
                          )
                        : Container(),
                  )
                  .toList()
            ]
            )
            )
            );
  }
}
