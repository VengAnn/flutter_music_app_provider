import 'package:flutter/material.dart';
import 'package:music_player/models/song.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayListProvider extends ChangeNotifier {
  // play list of song
  final List<Song> _playList = [
    // song 1
    Song(
      songName: "Dream It",
      artisName: "ROse 1",
      albumArtImagePath: "assets/images/rose1.jpg",
      audioPath: "audios/dream_it.mp3",
    ),
    // song 2
    Song(
      songName: "Like That",
      artisName: "rose 2",
      albumArtImagePath: "assets/images/rose_2.jpg",
      audioPath: "audios/like_that.mp3",
    ),
  ];
  // current song playing index
  int? _currentSongIndex;

  /*
  Audio player
  
   */

  // audio Player
  final AudioPlayer _audioPlayer = AudioPlayer();

  // duration
  // ignore: unused_field
  Duration _currentDuration = Duration.zero; // initialized with zero
  Duration _totalDuration = Duration.zero;

  // constructor
  PlayListProvider() {
    listenToDuration();
  }

  // initially not playing
  bool _isPlayer = false;

  // play song
  void play() async {
    final String path = _playList[_currentSongIndex!].audioPath;
    // ignore: avoid_print
    print("Audio file path: $path");
    // ignore: avoid_print
    print("test: ${AssetSource(path)}");
    await _audioPlayer.stop(); // stop the song
    await _audioPlayer.play(AssetSource(path)); // play new song
    _isPlayer = true;

    notifyListeners();
  }

  // pause current song
  void pause() async {
    await _audioPlayer.pause();
    _isPlayer = false;

    notifyListeners(); // tell UI update
  }

  // resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlayer = true;

    notifyListeners();
  }

  // pause or resume
  void pauseOrResume() async {
    if (_isPlayer) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  // seek to a spacific position in the current song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      // check if not the last index go to next song
      if (_currentSongIndex! < playList.length - 1) {
        setCurrentSongIndex = _currentSongIndex! + 1;
      } else {
        //if it's the last song, loop back to the first song
        setCurrentSongIndex = 0;
      }
    }
  }

  // play previous song
  void playPreviosSong() async {
    // if more then 2 seconds have passed, restart the current song
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        setCurrentSongIndex = _currentSongIndex! - 1;
      } else {
        // if it's the first song, loop back to last song
        setCurrentSongIndex = _playList.length - 1;
      }
    }
  }

  // listen to duration
  void listenToDuration() {
    // listen to total duration
    _audioPlayer.onDurationChanged.listen((newDuratin) {
      _totalDuration = newDuratin;

      notifyListeners();
    });

    // listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;

      notifyListeners();
    });

    // listen for song compeltetion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  // dispose audio player
  // ignore: annotate_overrides
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }

  /*
    Getter
     */
  List<Song> get playList => _playList;
  int? get currentSongIndex => _currentSongIndex;

  bool get isPlaying => _isPlayer;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  /*
    Setter
     */
  set setCurrentSongIndex(int? newIndex) {
    // update current song index
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      play(); // play the song at new index;
    }

    // update UI
    notifyListeners();
  }
}
