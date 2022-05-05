import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_tape/Pages/Refraction/editPlaylistName.dart';

import 'package:music_tape/Pages/Refraction/playlisttile.dart';
import 'package:music_tape/Pages/createplaylist.dart';
import 'package:music_tape/Pages/customplaylist.dart';
import 'package:music_tape/database/playlist_model.dart';
import 'package:music_tape/playlistscreen.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({Key? key}) : super(key: key);

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  final box = Playlistbox.getInstance();
  List playlists = [];
  String? playlistName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black, size: 35),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        title: Text(
          'Playlist',
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color.fromARGB(255, 214, 165, 236),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => createPlaylist(),
                      );
                    },
                    icon: Icon(
                      Icons.add,
                    ),
                  ),
                ),
              ],
            ),
            PlaylistTile(
                leadingicon: Icons.filter_none_outlined,
                iconcolor: Colors.black,
                iconsize: 30.0,
                titletext: 'Recently Added',
                subtitle: '20 Songs'),
            PlaylistTile(
                leadingicon: Icons.audio_file,
                iconcolor: Colors.black,
                iconsize: 30.0,
                titletext: 'Recently Played',
                subtitle: '30 Songs'),
            PlaylistTile(
                leadingicon: Icons.audiotrack,
                iconcolor: Colors.black,
                iconsize: 30.0,
                titletext: 'Most Played',
                subtitle: '40 Songs'),
            Expanded(
                child: ValueListenableBuilder(
                    valueListenable: box.listenable(),
                    builder: (context, boxes, _) {
                      playlists = box.keys.toList();
                      return ListView.builder(
                          itemCount: playlists.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: playlists[index] != "musics" &&
                                      playlists[index] != "favourites"
                                  ? CustomPlayList(
                                      titleNew: playlists[index].toString(),
                                      leadingNew: Icons.queue_music,
                                      trailingNew: PopupMenuButton(
                                        itemBuilder: (context) => [
                                          const PopupMenuItem(
                                            child: Text(
                                              'Remove Playlist',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'Poppins'),
                                            ),
                                            value: "0",
                                          ),
                                          const PopupMenuItem(
                                            value: "1",
                                            child: Text(
                                              "Rename Playlist",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'Poppins'),
                                            ),
                                          ),
                                        ],
                                        onSelected: (value) {
                                          if (value == "0") {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext
                                                        context) =>
                                                    AlertDialog(
                                                      title: Text(
                                                          'Do You Want to Delete'),
                                                      actions: [
                                                        TextButton.icon(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            icon: Icon(
                                                              Icons.cancel,
                                                              size: 20,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            label: Text(
                                                                'Cancel',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black,
                                                                ))),
                                                        TextButton.icon(
                                                            onPressed: () {
                                                              box.delete(
                                                                  playlists[
                                                                      index]);
                                                              setState(() {
                                                                playlists = box
                                                                    .keys
                                                                    .toList();
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            icon: Icon(
                                                              Icons.check,
                                                              size: 20,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            label: Text('Ok',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black,
                                                                )))
                                                      ],
                                                    ));
                                          }
                                          if (value == "1") {
                                            showDialog(
                                              context: context,
                                              builder: (context) => EditPlaylist(
                                                playlistName: playlists[index],
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                      ontapNew: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PlaylistScreen(
                                                      playlistName:
                                                          playlists[index],
                                                    )));
                                      },
                                    )
                                  : Container(),
                            );
                          });
                    }))
          ],
        ),
      ),
    );
  }
}

Future<void> addplaylistbutton(
  BuildContext context,
) async {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            color: Colors.white,
            height: 100,
            width: 200,
            child: Column(
              children: [
                TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.playlist_add),
                    label: Text('Add New Playlist')),
                TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.playlist_add_check_sharp),
                    label: Text('My Playlist')),
              ],
            ),
          ),
        );
        // AlertDialog(
        //   title: Text('Add New Playlist'),

        // );
      });
}
