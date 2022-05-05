import 'package:assets_audio_player/src/playable.dart';
import 'package:flutter/material.dart';
import 'package:music_tape/Pages/Refraction/drawer.dart';
import 'package:music_tape/Pages/Refraction/popupmenu.dart';
import 'package:music_tape/player/openplayer.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Albums extends StatelessWidget {
  List<Audio> fullsongs = [];
   Albums({Key? key, required this.fullsongs}) : super(key: key);

   final OnAudioQuery _audioQuery = OnAudioQuery();

  List<SongModel> songs = [];

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 214, 165, 236),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black, size: 35),
        
        title: Text(
          'Albums',
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
    
      ),
      body: FutureBuilder<List<SongModel>>(
        future: _audioQuery.querySongs(
            sortType: null,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true),
        builder: (context, item) {
          if (item.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (item.data!.isEmpty) {
            return Center(child: Text('No Songs Found'));
          }
          return ListView.builder(
            itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 10.0,
                childAspectRatio:8/10
              ),
              itemCount:fullsongs.length,
              itemBuilder: (context, index) {
                return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 100, 159, 207)),
                    child: QueryArtworkWidget(
                      artworkHeight: 200,artworkWidth: double.infinity,
                          id: int.parse(
                              fullsongs[index].metas.id.toString()),
                          artworkBorder: BorderRadius.circular(20.0),
                             nullArtworkWidget: Container(
                               height:200,width: double.infinity,
                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.grey,),
                               child: Icon(Icons.music_note_outlined,size: 50,)),
                          type: ArtworkType.AUDIO),
                  ),
                  SizedBox(height: 5),
                  Text(
                    fullsongs[index].metas.album.toString(),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                   fullsongs[index].metas.extra.toString(),
                  ),
                ],
                );
              },
            ),
          )
                ),
            itemCount:  fullsongs.length,
          );
        },
      ),
    );
  }
}





// Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: GridView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 20.0,
//                 mainAxisSpacing: 10.0,
//                 childAspectRatio:8/10
//               ),
//               itemCount: 10,
//               itemBuilder: (context, index) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: Color.fromARGB(255, 100, 159, 207)),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(20.0), //or 15.0
//                         child: Container(
//                           decoration: BoxDecoration(),
//                           height: 230.0,
//                           width: double.infinity,
//                           child: Image.asset(
//                             'asset/images/download.jpg',
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 5),
//                     Text(
//                       'KGF Chapter 2',
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                     ),
//                     Text(
//                       '123musiq.com',
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),