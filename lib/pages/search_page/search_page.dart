import 'package:flutter/material.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:music_player/models/song.dart';
import 'package:music_player/pages/song_page.dart';
import 'package:provider/provider.dart';

class SearchPage extends SearchDelegate {
  // This method is called when the search query changes
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // This button for back
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  // This method is called to build the main content of the search page
  @override
  Widget buildResults(BuildContext context) {
    return Consumer<PlayListProvider>(
      builder: (_, provider, __) {
        final List<Song> playList = provider.playList;
        final List<Song> filteredList = playList
            .where(
              (song) =>
                  song.songName.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

        if (query.isEmpty) {
          // Display a different widget or nothing when the query is empty
          return Container();
        } else if (filteredList.isEmpty) {
          return const Center(
            child: Text('No results found'),
          );
        } else {
          return ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final song = filteredList[index];
              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artisName),
                leading: Image.asset(song.albumArtImagePath),
                onTap: () => goToSong(index, context),
              );
            },
          );
        }
      },
    );
  }

  void goToSong(int songIndex, BuildContext context) {
    // Get the PlayListProvider instance using Provider.of
    PlayListProvider? playListProvider =
        Provider.of<PlayListProvider>(context, listen: false);

    // Check if playListProvider is not null before accessing setCurrentSongIndex
    // ignore: unnecessary_null_comparison
    if (playListProvider != null) {
      playListProvider.setCurrentSongIndex = songIndex;

      // Navigation to song page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SongPage(),
        ),
      );
    }
  }

  // This method is called to build suggestions while typing in the search bar
  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Song> filteredList =
        Provider.of<PlayListProvider>(context, listen: false)
            .playList
            .where(
              (song) =>
                  song.songName.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    if (query.isEmpty) {
      // Display a different widget or nothing when the query is empty
      return Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(child: Text("Please Search")),
            ),
          ],
        ),
      );
    } else if (filteredList.isEmpty) {
      return const Center(
        child: Text('No results found'),
      );
    } else {
      return ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          final song = filteredList[index];
          return ListTile(
            title: Text(song.songName),
            subtitle: Text(song.artisName),
            leading: Image.asset(song.albumArtImagePath),
            onTap: () => goToSong(index, context),
          );
        },
      );
    }
  }
}
