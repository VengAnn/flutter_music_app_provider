import 'package:flutter/material.dart';
import 'package:music_player/components/neu_box.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    // convert duration into min:sec
    String formatTime(Duration duration) {
      String twoDigitSeconds =
          duration.inSeconds.remainder(60).toString().padLeft(2, '0');
      String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";

      return formattedTime;
    }

    return Consumer<PlayListProvider>(
      builder: (context, value, child) {
        //get playlist
        final playList = value.playList;

        // get current index song
        final currentSong = playList[value.currentSongIndex ?? 0];

        // return Scaffold UI
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
              child: Column(
                children: [
                  //App bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //button back
                      IconButton(
                        onPressed: () {
                          // back
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                      //title
                      const Text("P L A Y L I S T"),
                      //menu button
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu),
                      ),
                    ],
                  ),
                  //
                  NeuBox(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                              fit: BoxFit.cover,
                              width: double.maxFinite,
                              height: 300,
                              currentSong.albumArtImagePath),
                        ),

                        // song and artist name icons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //song and artist name
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // song name
                                Text(currentSong.songName),
                                Text(currentSong.artisName),
                              ],
                            ),
                            // heart button
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),
                  //one more row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //start time
                        Text(formatTime(value.currentDuration)),

                        //shuffle icon
                        const Icon(Icons.shuffle),

                        // repeat icon
                        const Icon(Icons.repeat),

                        //end time
                        Text(formatTime(value.totalDuration)),
                      ],
                    ),
                  ),
                  // Song duration progress
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 0),
                    ),
                    child: Slider(
                      min: 0,
                      max: value.totalDuration.inSeconds.toDouble(),
                      value: value.currentDuration.inSeconds.toDouble(),
                      onChanged: (double double) {
                        // during if the user's sliding around
                      },
                      onChangeEnd: (double double) {
                        // slider has finished, go to that position in song
                        value.seek(Duration(seconds: double.toInt()));
                      },
                    ),
                  ),

                  // playback control
                  Row(
                    children: [
                      // skip previous
                      Expanded(
                        child: GestureDetector(
                          //call function when click
                          onTap: value.playPreviosSong,
                          child: const NeuBox(
                            child: Icon(Icons.skip_previous),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      // play pause
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: value.pauseOrResume,
                          child: NeuBox(
                            child: Icon(
                              value.isPlaying ? Icons.pause : Icons.play_arrow,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      // play next
                      Expanded(
                        child: GestureDetector(
                          onTap: value.playNextSong,
                          child: const NeuBox(
                            child: Icon(Icons.skip_next),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
