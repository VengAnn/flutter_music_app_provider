import 'package:flutter/material.dart';
import 'package:music_player/components/my_drawer.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:music_player/models/song.dart';
import 'package:music_player/pages/search_page/search_page.dart';
import 'package:music_player/pages/song_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //get the playlist provider
  late dynamic playListProvider;

  @override
  void initState() {
    super.initState();

    //get playList Provider
    playListProvider = Provider.of<PlayListProvider>(context, listen: false);
  }

  void goToSong(int songIndex) {
    // update current song Index
    playListProvider.setCurrentSongIndex = songIndex;

    //Navigation to song page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SongPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text("Music APP"),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchPage());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: Consumer<PlayListProvider>(
        builder: (context, value, child) {
          // get the playList song
          final List<Song> playList = value.playList;

          // return list view
          return ListView.builder(
            itemCount: playList.length,
            itemBuilder: (context, index) {
              final song = playList[index];
              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artisName),
                leading: Image.asset(song.albumArtImagePath),
                onTap: () => goToSong(index),
              );
            },
          );
        },
      ),
    );
  }
}
