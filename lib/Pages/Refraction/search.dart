import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_tape/database/playlist_model.dart';
import 'package:music_tape/player/openplayer.dart';
import 'package:on_audio_query/on_audio_query.dart';
 
class Search extends StatefulWidget {
  List<Audio> fullSongs = [];
  Search({Key? key, required this.fullSongs}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  final box = Playlistbox.getInstance();
  String search = "";

  List<Playlistmodel> dbSongs = [];
  List<Audio> allSongs = [];

  searchSongs() {
    dbSongs = box.get("musics") as List<Playlistmodel>;
    dbSongs.forEach(
      (element) {
        allSongs.add(
          Audio.file(
            element.songurl.toString(),
            metas: Metas(
                title: element.songname,
                id: element.id.toString(),
                artist: element.artist),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    searchSongs();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<Audio> searchTitle = allSongs.where((element) {
      return element.metas.title!.toLowerCase().startsWith(
            search.toLowerCase(),
          );
    }).toList();

    List<Audio> searchArtist = allSongs.where((element) {
      return element.metas.artist!.toLowerCase().startsWith(
            search.toLowerCase(),
          );
    }).toList();

    List<Audio> searchResult = [];  
    if (searchTitle.isNotEmpty) {
      searchResult = searchTitle;
    } else {
      searchResult = searchArtist;
    }

    return SafeArea(
      
      child: Scaffold(
            backgroundColor: Color.fromARGB(255, 214, 165, 236),
        appBar: AppBar(
          iconTheme: IconThemeData (color: Colors.black),

          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,

          title: const Text(
            'Search',style: TextStyle(color: Colors.black),
          ),
        ),
        // ignore: sized_box_for_whitespace
        body: Container(
          height: height,
          width: width,
          child: Column(
            children: [
         
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  
                ),
                height: MediaQuery.of(context).size.height * .07,
                width: MediaQuery.of(context).size.width * .9,
                child: TextField(
                  cursorHeight:18,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(top: 14, right: 10, left: 10),
                    suffixIcon: Icon(Icons.search,color: Colors.black,),
                    
                    hintText: ' Search a song',
                    filled: true,
                    
                        ),
                  onChanged: (value) {
                    setState(
                      () {
                        search = value.trim();
                      },
                    );
                  },
                ),
              ),
              search.isNotEmpty
                  ? searchResult.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: searchResult.length,
                            itemBuilder: (context, index) {
                              return FutureBuilder(
                                future: Future.delayed(
                                  const Duration(microseconds: 0),
                                ),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return GestureDetector(
                                      onTap: () {
                                        OpenPlayer(
                                                fullSongs: searchResult,
                                                index: index)
                                            .openAssetPlayer(
                                                index: index,
                                                songs: searchResult);
                                      },
                                      child: ListTile(
                                        leading: SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: QueryArtworkWidget(
                                            id: int.parse(
                                                searchResult[index].metas.id!),
                                            type: ArtworkType.AUDIO,
                                            artworkBorder:
                                                BorderRadius.circular(15),
                                            artworkFit: BoxFit.cover,
                                            nullArtworkWidget: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15)),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/logodefault.jpg"),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          searchResult[index].metas.title!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        subtitle: Text(
                                          searchResult[index].metas.artist!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return Container();
                                },
                              );
                            },
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.all(30),
                          child: Text(
                            "No Result Found",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                            ),
                          ),
                        )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
