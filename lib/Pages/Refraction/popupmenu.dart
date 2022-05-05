import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_tape/Pages/Refraction/playlistlist.dart';

import 'package:music_tape/database/playlist_model.dart';

class MusicListMenu extends StatelessWidget {
  final String songId;
  MusicListMenu({Key? key, required this.songId}) : super(key: key);

  final box = Playlistbox.getInstance();

  List<Playlistmodel> dbSongs = [];
  List<Audio> fullSongs = [];

  List playlists = [];

  List<dynamic>? playlistSongs = [];

  @override
  Widget build(BuildContext context) {
    dbSongs = box.get("musics") as List<Playlistmodel>;

    List? favourites = box.get("favourites");

    final temp = databaseSongs(dbSongs, songId);

    return PopupMenuButton(
        icon: Icon(Icons
            .more_vert_outlined), //don't specify icon if you want 3 dot menu
        itemBuilder: (BuildContext context) => [
              favourites!
                      .where((element) =>
                          element.id.toString() == temp.id.toString())
                      .isEmpty
                  ? PopupMenuItem(
                      onTap: () async {
                        favourites.add(temp);
                        await box.put("favourites", favourites);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              temp.songname! + " Added to Favourites",
                              style: const TextStyle(fontFamily: 'Poppins'),
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "Add to Favourite",
                        style: TextStyle(fontFamily: 'Poppins'),
                      ),
                    )
                  : PopupMenuItem(
                      onTap: () async {
                        favourites.removeWhere((element) =>
                            element.id.toString() == temp.id.toString());
                        await box.put("favourites", favourites);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              temp.songname! + " Removed from Favourites",
                              style: const TextStyle(fontFamily: 'Poppins'),
                            ),
                          ),
                        );
                      },
                      child: Text('Remove From Favourites')),
              PopupMenuItem(
                value: 1,
                child: Text(
                  "Add to Playlist",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
        onSelected: (value) async {
          if (value == 1) {
            showDialog(
              context: context,
              builder: (BuildContext context) => PlaylistList(song: temp),
            );
          }
        });
  }

  Playlistmodel databaseSongs(List<Playlistmodel> songs, String id) {
    return songs.firstWhere(
      (element) => element.songurl.toString().contains(id),
    );
  }
}
