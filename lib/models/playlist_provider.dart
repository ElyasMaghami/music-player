import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:musicplayer/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  //playlist of songs
  final List<Song> _playlist = [
    Song(
        songName: 'HeartBeat',
        artistName: "Enriqe-Iglesias-HeartBeat",
        albumImagePath: "assets/images/enriq.jpg",
        audioPath: "assets/audio/Enriqiglesias-HeartBeat.mp3"),
    Song(
        songName: 'icim deki',
        artistName: 'ilyas',
        albumImagePath: "assets/images/ilyasyalcintas.jpg",
        audioPath: "assets/audio/Ilyas-icimdeki.mp3"),
    Song(
        songName: 'russian',
        artistName: 'NoMan',
        albumImagePath: "assets/images/gangster.jpg",
        audioPath: "assets/audio/rusian.mp3"),
    Song(
        songName: 'russian girl',
        artistName: 'swerodo',
        albumImagePath: "assets/images/russ.jpg",
        audioPath: "assets/audio/swerodo.mp3"),
  ];

//current song playing index
  int? _currentSongIndex;

/*
Audio Play
*/
// audio play

  final AudioPlayer _audioPlayer = AudioPlayer();
//durations

  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

//constructor
  PlaylistProvider() {
    listenToDuration();
  }
//initially not playing

  bool _isPlaying = false;

//play the song
  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(
      AssetSource(path),
    );
    await AudioPlayer().audioCache.clearAll();
    _isPlaying = true;
    notifyListeners();
  }

//pause the song

  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

//resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

//pause or resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

//seek to specific position in the current song

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

//play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        _currentSongIndex = currentSongIndex! + 1;
      } else {
        _currentSongIndex = 0;
      }
    }
  }
//play previous song

  void playPreviousSong() async {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length - 1;
      }
    }
  }
//list to duration

  void listenToDuration() {
    //listen for total duration

    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });
    //listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });
    //listen for song completion
    _audioPlayer.onPlayerComplete.listen((completDuration) {
      playNextSong();
    });
  }

//dispose audio player

/*
getters
*/
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

/*
setters
*/
  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play();
    }
    //update UI
    notifyListeners();
  }
}
