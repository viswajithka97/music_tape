import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:music_tape/home.dart';
import 'package:music_tape/Database/playlist_model.dart';
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

  final _audioQuery = OnAudioQuery();
  final box = Playlistbox.getInstance();

  List<Audio> fullSongs = [];
  List<SongModel> fetchedSongs = [];
  List<SongModel> allSongs = [];
  List<Playlistmodel> dbSongs = [];
  List<Playlistmodel> mappedSongs = [];

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
    mappedSongs = allSongs
        .map(
          (audio) => Playlistmodel(
              songname: audio.title, 
              artist: audio.artist,
              songurl: audio.uri,
              duration: audio.duration,
              id: audio.id),
        )
        .toList();

    await box.put("musics", mappedSongs);
    dbSongs = box.get("musics") as List<Playlistmodel>;

    for (var element in dbSongs) {
      fullSongs.add(
        Audio.file(
          element.songurl.toString(),
          metas: Metas(
              title: element.songname,
              id: element.id.toString(),
              artist: element.songurl),
        ),
      );
    }
    setState(() {});
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
