// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:music_tape/database/playlist_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongSheet extends StatefulWidget {
  String playlistName;
  SongSheet({Key? key, required this.playlistName}) : super(key: key);

  @override
  State<SongSheet> createState() => _SongSheetState();
}

class _SongSheetState extends State<SongSheet> {
  final box = Playlistbox.getInstance();

  List<Playlistmodel> dbSongs = [];
  List<Playlistmodel> playlistSongs = [];
  @override
  void initState() {
    super.initState();
    fullSongs();
  }

  fullSongs() {
    dbSongs = box.get("musics") as List<Playlistmodel>;

    playlistSongs = box.get(widget.playlistName)!.cast<Playlistmodel>();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dbSongs.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: SizedBox(
              height: 50,
              width: 50,
              child: QueryArtworkWidget(
                id: dbSongs[index].id!,
                type: ArtworkType.AUDIO,
                artworkBorder: BorderRadius.circular(15),
                artworkFit: BoxFit.cover,
                // nullArtworkWidget: Container(
                //   height: 50,
                //   width: 50,
                //   decoration: const BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(15)),
                //     image: DecorationImage(
                //       image: AssetImage("assets/images/logodefault.jpg"),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
              ),
            ),
            title: Text(
              dbSongs[index].songname!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              dbSongs[index].artist!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: playlistSongs
                    .where((element) =>
                        element.id.toString() == dbSongs[index].id.toString())
                    .isEmpty
                ? IconButton(
                    onPressed: () async {
                      playlistSongs.add(dbSongs[index]);
                      await box.put(widget.playlistName, playlistSongs);

                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.black,
                    ))
                : IconButton(
                    onPressed: () async {
                      playlistSongs.removeWhere((elemet) =>
                          elemet.id.toString() == dbSongs[index].id.toString());

                      await box.put(widget.playlistName, playlistSongs);
                      setState(() {});
                    },
                    icon: const Icon(Icons.check_box, color: Colors.black),
                  ),
          ),
        );
      },
    );
  }
}
