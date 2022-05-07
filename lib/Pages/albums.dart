// ignore: implementation_imports
import 'package:assets_audio_player/src/playable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class Albums extends StatelessWidget {
  List<Audio> fullsongs = [];

  Albums({Key? key, required this.fullsongs}) : super(key: key);

  final OnAudioQuery _audioQuery = OnAudioQuery();

  List<SongModel> songs = [];
  List<dynamic> albumname = [];

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
          backgroundColor: const Color.fromARGB(255, 146, 93, 199),
          iconTheme: IconThemeData(color: Colors.black, size: 35.h.w),
          title: Text(
            'Albums',
            style: TextStyle(fontSize: 25.h.w, color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  print(albumname);
                },
                icon: Icon(
                  Icons.music_note_outlined,
                  size: 50.h.w,
                )),
          ],
        ),
        body: FutureBuilder<List<SongModel>>(
          future: _audioQuery.querySongs(
              sortType: null,
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.EXTERNAL,
              ignoreCase: true),
          builder: (context, item) {
            if (item.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (item.data!.isEmpty) {
              return const Center(child: Text('No Songs Found'));
            }
            return ListView.builder(
              itemBuilder: (context, index) => Padding(
                  padding:
                      EdgeInsets.only(top: 10.0.h, left: 10.0.w, right: 10.0.w),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20.0.w,
                          mainAxisSpacing: 10.0.h,
                          childAspectRatio: 8.h / 10.w),
                      itemCount: albumname.length,
                      itemBuilder: (context, index) {
                        
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      const Color.fromARGB(255, 100, 159, 207)),
                              child: QueryArtworkWidget(
                                  artworkHeight: 200.h,
                                  artworkWidth: double.infinity,
                                  id: int.parse(fullsongs[index].metas.id.toString()),
                                  artworkBorder: BorderRadius.circular(20.0),
                                  nullArtworkWidget: Container(
                                      height: 200.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey,
                                      ),
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.music_note_outlined,
                                            size: 50.h.w,
                                          ))),
                                  type: ArtworkType.AUDIO),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              albumname[index],
                              // fullsongs[index].metas.album.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.h.w),
                            ),
                            Text(
                              fullsongs[index].metas.extra.toString(),
                            ),
                          ],
                        );
                      },
                    ),
                  )),
              itemCount: albumname.length,
            );
          },
        ),
      ),
    );
  }
}
