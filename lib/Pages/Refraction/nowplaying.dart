// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/material.dart';
// import 'package:music_tape/Pages/Refraction/nowplayingscreen.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class NowPlaying extends StatelessWidget {

//   List<SongModel> fullSongs;
//   int index;
//   NowPlaying({
//     Key? key, required this.index, required this.fullSongs ,
//   }) : super(key: key);

//     final _audioQuery = OnAudioQuery();
//     final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

//   Audio find(List<Audio> source, String fromPath) {
//     return source.firstWhere((element) => element.path == fromPath);
//   }

//   @override
//   Widget build(BuildContext context) {
 
//   }
// }
  // Future<void> showmodalsheet (BuildContext context)async{
  //   showModalBottomSheet(context: context, builder: (ctx1){
  //   return  NowPlayingScreen();
  //   });

  // }




//  if (isPlayerViewvisible) {
//       return Scaffold(
//         backgroundColor: Color.fromARGB(255, 214, 165, 236),
//         appBar: AppBar(
//           elevation: 0,
//           centerTitle: true,
//           title: Text(
//             'Now Playing',
//             style: TextStyle(fontSize: 25),
//           ),
//           backgroundColor: Colors.transparent,
//           automaticallyImplyLeading: false,
//           actions: [
//             IconButton(
//                 onPressed: () {
//                   _changePlayerVisibility();
//                 },
//                 icon: Icon(
//                   Icons.keyboard_arrow_down_rounded,
//                   size: 30,
//                 ))
//           ],
//         ),
//         body: SafeArea(
//           child: Center(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(50.0),
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: 60,
//                       ),
//                       QueryArtworkWidget(
//                           id: songs[currentIndex].id,
//                           artworkHeight: 400,
//                           artworkWidth: double.infinity,
//                           artworkBorder: BorderRadius.circular(5.0),
//                           type: ArtworkType.AUDIO),
//                       SizedBox(
//                         height: 50,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Icon(
//                             Icons.tune,
//                             size: 35,
//                           ),
//                           Icon(
//                             Icons.favorite,
//                             color: Colors.red,
//                             size: 35,
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       LinearPercentIndicator(
//                         lineHeight: 10,
//                         percent: 0.4,
//                         barRadius: const Radius.circular(16),
//                         progressColor: Color.fromARGB(255, 179, 31, 147),
//                         backgroundColor: Colors.grey[300],
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             '1.35',
//                             style: TextStyle(
//                               fontSize: 20,
//                             ),
//                           ),
//                           Text(
//                             '4.35',
//                             style: TextStyle(
//                               fontSize: 20,
//                             ),
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     IconButton(
//                         onPressed: () {}, icon: Icon(Icons.shuffle, size: 35)),
//                     IconButton(
//                         onPressed: () {
//                           if (_player.hasPrevious) {
//                             _player.seekToPrevious();
//                           }
//                         },
//                         icon: Icon(Icons.skip_previous,
//                             size: 40, color: Colors.white)),
//                     Flexible(
//                       child: InkWell(
//                         onTap: () {
//                           if (_player.playing) {
//                             _player.pause();
//                           } else {
//                             if (_player.currentIndex != null) {
//                               _player.play();
//                             }
//                           }
//                         },
//                         child: Container(
//                           height: 80,
//                           width: 80,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(60),
//                               color: Colors.white),
//                           child: StreamBuilder<bool>(
//                             stream: _player.playingStream,
//                             builder: (context, snapshot) {
//                               bool? playingState = snapshot.data;
//                               if (playingState != null && playingState) {
//                                 return const Icon(
//                                   Icons.pause,
//                                   size: 60,
//                                 );
//                               }
//                               return const Icon(
//                                 Icons.play_arrow,
//                                 size: 60,
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                         onPressed: () {
//                           if (_player.hasNext) {
//                             _player.seekToNext();
//                           }
//                         },
//                         icon: Icon(Icons.skip_next,
//                             size: 40, color: Colors.white)),
//                     IconButton(
//                         onPressed: () {},
//                         icon: Icon(
//                           Icons.playlist_add,
//                           size: 35,
//                         )),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       );
//     }