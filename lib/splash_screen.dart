import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:music_tape/home.dart';
import 'package:on_audio_query/on_audio_query.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    requestStoragePermission();
    home();
    super.initState();
  }

  final OnAudioQuery _audioQuery = OnAudioQuery();

  List<Audio> fullSongs = [];
  List<SongModel> fetchedSongs = [];
  List<SongModel> allSongs = [];

  requestStoragePermission() async {
    bool permissionStatus = await _audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await _audioQuery.permissionsRequest();
    }
    setState(() {});

    fetchedSongs = await _audioQuery.querySongs();

    for (var element in fetchedSongs) {
      if (element.fileExtension == "mp3") {
        allSongs.add(element);
      }
    }

    for (var element in allSongs) {
      fullSongs.add(
        Audio.file(
          element.uri.toString(),
          metas: Metas(
              title: element.title,
              id: element.id.toString(),
              artist: element.artist),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 207, 128, 221),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Music Tape',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Image.asset('asset/images/splash.png'),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Feel the Music',
              style: TextStyle(fontSize: 30, color: Colors.white),
            )
          ],
        ),
      )),
    );
  }

  Future<void> home() async {
    await Future.delayed(
      const Duration(seconds: 4),
    );

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => Home(allsongs: fullSongs)));
  }
}
