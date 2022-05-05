import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_tape/Pages/Refraction/drawer.dart';
import 'package:music_tape/Pages/Refraction/popupmenu.dart';
import 'package:music_tape/database/playlist_model.dart';
import 'package:music_tape/player/nowplayingscreen.dart';
import 'package:music_tape/player/openplayer.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  List<Playlistmodel>? dbSongs = [];
  List<Audio> playliked = [];
  final box = Playlistbox.getInstance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 214, 165, 236),
      
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black, size: 35),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
          title: Text(
            'Favourites',
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),
        ),
        body: SafeArea(
            child: ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, value, child) {
                  var likedSongs = box.get("favourites");
                  return ListView.builder(
                    itemCount: likedSongs!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(

                         onTap : () {
                           for (var element in likedSongs) {
                              playliked.add(
                                Audio.file(
                                  element.songurl!,
                                  metas: Metas(
                                    title: element.songname,
                                    id: element.id.toString(),
                                    artist: element.artist
                                  )
                                )
                              );
                             
                           }
                            OpenPlayer(fullSongs: playliked, index: index)
                                .openAssetPlayer(index: index, songs: playliked);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NowPlayingScreen(
                                  fullSongs: playliked,
                                  index: index,
                                ),
                              ),
                            );
                         },
                        child: Container(
                        child: likedSongs[index] != "musics"
                            ? ListTile(
                                title: Text(likedSongs[index].songname),
                                subtitle: Text(likedSongs[index].artist),
                                leading: QueryArtworkWidget(
                                  id: likedSongs[index].id!,
                                  type: ArtworkType.AUDIO,
                                  artworkBorder: BorderRadius.circular(15),
                                  artworkFit: BoxFit.cover,
                                  // nullArtworkWidget: Container(
                                  //   height: 50,
                                  //   width: 50,
                                  //   decoration: const BoxDecoration(
                                  //     borderRadius:
                                  //         BorderRadius.all(Radius.circular(15)),
                                  //     image: DecorationImage(
                                  //       image: AssetImage(
                                  //           "assets/images/logodefault.jpg"),
                                  //       fit: BoxFit.cover,
                                  //     ),
                                  //   ),
                                  // ),
                                ),

                                trailing:MusicListMenu(songId: likedSongs[index].id.toString())
                              )
                            : Container(),
                      ),
                      );
                    },
                  );
                })));
  }
}
