import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_tape/database/playlist_model.dart';

import 'package:music_tape/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(PlaylistmodelAdapter());

  await Hive.openBox<List>(boxname);

  final box = Playlistbox.getInstance();

  List<dynamic> favKeys = box.keys.toList();
  

  if (!(favKeys.contains("favourites"))) {

    List<dynamic> likedSongs = [];

    await box.put("favourites", likedSongs);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splashScreen(),
    );
  }
}
