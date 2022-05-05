import 'package:flutter/material.dart';
import 'package:music_tape/Database/playlist_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class createPlaylist extends StatefulWidget {
createPlaylist({Key? key}) : super(key: key);

  @override
  State<createPlaylist> createState() => _createPlaylistState();
}

class _createPlaylistState extends State<createPlaylist> {
  List<Playlistmodel> playlists = [];
  final box = Playlistbox.getInstance();
  String? title;
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Playlist Name'),
      content: Form(
          key: formkey,
          child: TextFormField(
            onChanged: (value) {
              title = value.trim();
            },
            validator: (value) {
              List keys = box.keys.toList();
              if (value!.trim() == "") {
                return "Name Required";
              }
              if (keys.where((element) => element == value.trim()).isNotEmpty) {
                return "This Name Already Exists";
              }
              return null;
            },
          )),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel',style: TextStyle(color: Colors.black),)),
            TextButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    box.put(title, playlists);
                    Navigator.pop(context);
                    setState(() {});
                  }
                },
                child: Text('Save',style: TextStyle(color: Colors.black),)),
          ],
        ),
      ],
    );
  }
}
