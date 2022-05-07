import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_tape/Pages/Refraction/popupmenu.dart';
import 'package:music_tape/database/db_model.dart';
import 'package:music_tape/player/nowplayingscreen.dart';
import 'package:music_tape/player/openplayer.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  List<Songmodel>? dbSongs = [];
  List<Audio> playliked = [];
  final box = Songbox.getInstance();
  @override
  Widget build(BuildContext context) {
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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            iconTheme:const IconThemeData(color: Colors.black, size: 35),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 146, 93, 199),
            elevation: 0,
            leading: IconButton(
              icon:const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
            title: Text(
              'Favourites',
              style: TextStyle(fontSize: 25.sp, color: Colors.black),
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
                          onTap: () {
                            for (var element in likedSongs) {
                              playliked.add(Audio.file(element.songurl!,
                                  metas: Metas(
                                      title: element.songname,
                                      id: element.id.toString(),
                                      artist: element.artist)));
                            }
                            OpenPlayer(fullSongs: playliked, index: index)
                                .openAssetPlayer(
                                    index: index, songs: playliked);

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
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        top: 10.0.h, left: 10.0.w, right: 10.0.w),
                                    child: Container(
                                      height: 75.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: const Color.fromARGB(
                                              106, 217, 197, 218)),
                                      child: ListTile(
                                          title:
                                              Text(likedSongs[index].songname),
                                          subtitle:
                                              Text(likedSongs[index].artist),
                                          leading: QueryArtworkWidget(
                                            id: likedSongs[index].id!,
                                            type: ArtworkType.AUDIO,
                                            artworkBorder:
                                                BorderRadius.circular(15),
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
                                          trailing: MusicListMenu(
                                              songId: likedSongs[index]
                                                  .id
                                                  .toString())),
                                    ),
                                  )
                                : Container(),
                          ),
                        );
                      },
                    );
                  }))),
    );
  }
}
