import 'package:flutter/material.dart';
import 'package:music_tape/database/playlist_model.dart';

class EditPlaylist extends StatelessWidget {
  EditPlaylist({Key? key, required this.playlistName}) : super(key: key);
  final String playlistName;
  final _box = Playlistbox.getInstance();
  String? _title;
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // shape: Border.all(
      //   width: 1,
      //   color: Colors.white,
      // ),
      // backgroundColor: Colors.black,
      title: Text(
              "Edit your playlist name.",
              style: TextStyle(
                // color: Colors.black,
                fontSize: 18,
              ),
            ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: 10,
            ),
            child: Form(
              key: formkey,
              child: TextFormField(
                initialValue: playlistName,
                cursorHeight: 25,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                onChanged: (value) {
                  _title = value.trim();
                },
                validator: (value) {
                  List keys = _box.keys.toList();
                  if (value!.trim() == "") {
                    return "name Required";
                  }
                  if (keys
                      .where((element) => element == value.trim())
                      .isNotEmpty) {
                    return "this name already exits";
                  }
                  return null;
                },
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15,
                    top: 5,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                       
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15,
                    top: 5,
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        List? playlists = _box.get(playlistName);
                        _box.put(_title, playlists!);
                        _box.delete(playlistName);
                        Navigator.pop(context);
                      }
                    },
                    child: const Center(
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                         
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
