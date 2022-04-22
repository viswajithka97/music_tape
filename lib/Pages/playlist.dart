import 'package:flutter/material.dart';
import 'package:music_tape/Pages/Refraction/drawer.dart';
import 'package:music_tape/Pages/Refraction/playlisttile.dart';
import 'package:on_audio_query_platform_interface/details/on_audio_query_helper.dart';

class playlist extends StatelessWidget {
  const playlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black, size: 35),
        title: Text(
          'Playlist',
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:18.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                
                Icons.search),
            ),
          )
        ],
      ),
      backgroundColor: Color.fromARGB(255, 214, 165, 236),
      body: SafeArea(
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: IconButton(
                    onPressed: () {
                      addplaylistbutton(context);
                    },
                    icon: Icon(
                      Icons.add,
                    ),
                  ),
                ),
              ],
            ),
            PlaylistTile(
                leadingicon: Icons.favorite,
                iconcolor: Colors.red,
                iconsize: 30.0,
                titletext: 'My Favourites',
                subtitle: '50 Songs',
                trailingicon: Icons.more_vert_outlined),
            PlaylistTile(
                leadingicon: Icons.filter_none_outlined,
                iconcolor: Colors.black,
                iconsize: 30.0,
                titletext: 'Recently Added',
                subtitle: '20 Songs'),
            PlaylistTile(
                leadingicon: Icons.audio_file,
                iconcolor: Colors.black,
                iconsize: 30.0,
                titletext: 'Recently Played',
                subtitle: '30 Songs'),
            PlaylistTile(
                leadingicon: Icons.audiotrack,
                iconcolor: Colors.black,
                iconsize: 30.0,
                titletext: 'Most Played',
                subtitle: '40 Songs'),
            PlaylistTile(
                leadingicon: Icons.playlist_add,
                iconcolor: Colors.black,
                iconsize: 30.0,
                titletext: 'My Playlist',
                subtitle: '25 Songs',
                trailingicon: Icons.more_vert_outlined),
          ],
        ),
      ),
    );
  }

  
}
Future<void> addplaylistbutton(BuildContext context,) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              color: Colors.white,
              height: 100,
              width: 200,
              child: Column(
                children: [
                  TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.playlist_add),
                      label: Text('Add New Playlist')),
                  TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.playlist_add_check_sharp),
                      label: Text('My Playlist')),
                ],
              ),
            ),
          );
          // AlertDialog(
          //   title: Text('Add New Playlist'),

          // );
        });
  }
