import 'package:flutter/material.dart';
import 'package:music_tape/database/db_model.dart';
import 'package:music_tape/player/nowplayingscreen.dart';
import 'package:music_tape/player/openplayer.dart';
import 'package:music_tape/splash_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class listPathSongs extends StatefulWidget {
  final int index;
  const listPathSongs({Key? key, required this.index}) : super(key: key);

  @override
  State<listPathSongs> createState() => _listPathSongsState();
}

List<dynamic> pathSongList = [];

class _listPathSongsState extends State<listPathSongs> {
  @override
  Widget build(BuildContext context) {
    List<String> _getSplitPath = [];
    for (var i = 1; i < allSongs.length; i++) {
      String _path = allSongs[i].data.toString();
      _getSplitPath = _path.split('/').toList();

      if (_getSplitPath[_getSplitPath.length - 2] == gotPath[widget.index]) {
        pathSongList.add(allSongs[i]);
      }
    }
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
        body: SafeArea(
            child: ListView.builder(
                itemCount: pathSongList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: 10.0.h, left: 10.0.w, right: 10.0.w),
                    child: Container(
                      height: 75.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(106, 217, 197, 218)),
                      child: ListTile(
                        title: GestureDetector(
                            onTap: () {
                              print(pathSongList.length);
                              // OpenPlayer(fullSongs: fullSongs, index: pathSongList[index]);
                              // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NowPlayingScreen(index: index, fullSongs:fullSongs)));
                            },
                            child: Text(pathSongList[index].title)),
                        leading: Container(
                          // decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),color: Colors.white30,),
                          height: 43,
                          width: 43,

                          // color: Colors.grey,
                          child: QueryArtworkWidget(
                            artworkBorder: BorderRadius.all(Radius.circular(7)),
                            // artworkClipBehavior: Clip.antiAliasWithSaveLayer,
                            artworkFit: BoxFit.fill,
                            nullArtworkWidget: ClipRRect(
                                child: Image.asset(
                              'asset/images/new3.png',
                              color: Colors.white30,
                            )),
                            id: int.parse(pathSongList[index].id.toString()),
                            type: ArtworkType.AUDIO,
                          ),
                        ),
                      ),
                    ),
                  );
                })),
      ),
    );
  }

  Set<Songmodel> pathSongListset = {};
}
