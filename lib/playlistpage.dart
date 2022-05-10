import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_tape/Pages/Refraction/editPlaylistName.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_tape/Pages/createplaylist.dart';
import 'package:music_tape/Pages/customplaylist.dart';
import 'package:music_tape/database/db_model.dart';
import 'package:music_tape/playlistscreen.dart';
import 'package:music_tape/recentlyplayed.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({Key? key}) : super(key: key);

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  final box = Songbox.getInstance();
  List playlists = [];
  List<PlaylistModel>? playlistSongs = [];

  String? playlistName = '';

  @override
  Widget build(BuildContext context) {
    var recentplay = box.get("Recently_Played");

    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0.6, -0.10),
          colors: [
            Color(0xFFAD78E1),
            Color(0xFFB59CDA),
            Color(0xFFC28ADC),
            Color(0xFFAA8BE5),
            Color(0xFFAD78E1),
            Color(0xFFAB76E0),
          ],
          radius: 1.5,
          focalRadius: 15.5,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black, size: 35.sp),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
          title: Text(
            'Playlist',
            style: TextStyle(fontSize: 25.sp, color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 146, 93, 199),
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 16.0.w),
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const createPlaylist(),
                        );
                      },
                      icon: Icon(
                        Icons.add,
                        size: 35.h.w,
                      ),
                    ),
                  ),
                ],
              ),
              // PlaylistTile(
              //     leadingicon: Icons.filter_none_outlined,
              //     iconcolor: Colors.black,
              //     iconsize: 30.0,
              //     titletext: 'Recently Added',
              //     subtitle: '20 Songs'),
              Padding(
                padding:
                    EdgeInsets.only(top: 10.0.h, left: 10.0.w, right: 10.0.w),
                child: Container(
                  height: 75.h,
                  width: double.infinity.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(106, 217, 197, 218)),
                  child: ListTile(
                    leading: const Icon(
                      Icons.audio_file,
                      color: Colors.black,
                      size: 30.0,
                    ),
                    title: const Text(
                      'Recently Played',
                    ),
                    subtitle: Text(
                      '${recentplay!.length} Songs',
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RecentlyPlayed()));
                    },
                  ),
                ),
              ),
              // PlaylistTile(
              //     leadingicon: Icons.audiotrack,
              //     iconcolor: Colors.black,
              //     iconsize: 30.0,
              //     titletext: 'Most Played',
              //     subtitle: '40 Songs'),
              Expanded(
                  child: ValueListenableBuilder(
                      valueListenable: box.listenable(),
                      builder: (context, boxes, _) {
                        playlists = box.keys.toList();
                        return ListView.builder(
                            itemCount: playlists.length,
                            itemBuilder: (context, index) {
                              var playlistSongs = box.get(playlists[index])!;

                              return Container(
                                child: playlists[index] != "musics" &&
                                        playlists[index] != "favourites" &&
                                        playlists[index] != "Recently_Played"
                                    ? CustomPlayList(
                                        titleNew: playlists[index].toString(),
                                        subtitileNew:
                                            playlistSongs.length.toString(),
                                        leadingNew: Icons.queue_music,
                                        trailingNew: PopupMenuButton(
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              child: Text(
                                                'Remove Playlist',
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                ),
                                              ),
                                              value: "0",
                                            ),
                                            PopupMenuItem(
                                              value: "1",
                                              child: Text(
                                                "Rename Playlist",
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                ),
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
                                                        title: const Text(
                                                            'Do You Want to Delete'),
                                                        actions: [
                                                          TextButton.icon(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              icon: Icon(
                                                                Icons.cancel,
                                                                size: 20.h.w,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              label: Text(
                                                                  'Cancel',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize: 20
                                                                      ..h.w,
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
                                                                size: 20.h.w,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              label: Text('Ok',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20.sp,
                                                                    color: Colors
                                                                        .black,
                                                                  )))
                                                        ],
                                                      ));
                                            }
                                            if (value == "1") {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    EditPlaylist(
                                                  playlistName:
                                                      playlists[index],
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
      ),
    );
  }
}
