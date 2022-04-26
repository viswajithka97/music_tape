import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_tape/Pages/Refraction/playlistlist.dart';
import 'package:music_tape/Pages/createplaylist.dart';
import 'package:music_tape/playlistpage.dart';
import 'package:music_tape/Database/playlist_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicListMenu extends StatelessWidget {
  final String songId;
  //  Playlistmodel song;
  MusicListMenu({Key? key, required this.songId}) : super(key: key);

  final box = Playlistbox.getInstance();
  List<Playlistmodel> dbSongs = [];
  List<Audio> fullSongs = [];

  List playlists = [];
  List<dynamic>? playlistSongs = [];

  @override
  Widget build(BuildContext context) {
    dbSongs = box.get("musics") as List<Playlistmodel>;
    final temp = databaseSongs(dbSongs, songId);
    return PopupMenuButton(
      icon: Icon(
          Icons.more_vert_outlined), //don't specify icon if you want 3 dot menu
      // color: Colors.blue,
      itemBuilder: (context) => [
        PopupMenuItem(
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
                                style: TextStyle(color: Colors.blue),
                              ),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => createPlaylist());
                              },
                            ),
                            PlaylistList(song: temp),
                          ],
                        )),
                  );
                })
          }
      },
    );
  }

  Playlistmodel databaseSongs(List<Playlistmodel> songs, String id) {
    return songs.firstWhere(
      (element) => element.songurl.toString().contains(id),
    );
  }
}
