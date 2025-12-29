import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:voice_note_kit/player/audio_player_widget.dart';
import 'package:voice_note_kit/player/player_enums/player_enums.dart';

class AudioPlayerReuse extends StatelessWidget {
  const AudioPlayerReuse({super.key, required this.soundPath});

  final String soundPath;

  @override
  Widget build(BuildContext context) {
    return AudioPlayerWidget(
      // autoPlay: false,
      // Whether to automatically start playback when the widget builds
      // autoLoad: true,
      // Whether to preload the audio before the user presses play
      audioPath: soundPath,
      // The path or URL of the audio file
      audioType: AudioType.url,
      // Specifies if the audio is from a URL, asset, , file , or blobforWeb(for flutter web)
      playerStyle: PlayerStyle.style5,
      // The visual style of the player (you can choose between different predefined styles)
      textDirection: TextDirection.rtl,
      // Text direction for RTL or LTR languages
      size: 60,
      // Size of the play/pause button
      progressBarHeight: 5,
      // Height of the progress bar
      backgroundColor: AppColors.cPrimary,
      // Background color of the widget
      progressBarColor: AppColors.cPrimary,
      // Color of the progress bar (played portion)
      progressBarBackgroundColor: Colors.white,
      // Background color of the progress bar
      // iconColor: Colors.white,
      // Color of the play/pause icon
      // shapeType: PlayIconShapeType.circular,
      // Shape of the play/pause button (e.g., circular or square)
      // showProgressBar: true,
      // Whether to show the progress bar
      // showTimer: true,
      // Whether to display the current time/duration
      width: 300,
      // Width of the whole audio player widget
      audioSpeeds: const [0.5, 1.0, 1.5, 2.0, 3.0],
      // Supported audio playback speeds
      // onSeek: (value) => print('Seeked to: $value'),
      // Callback when user seeks to a new position
      // onError: (message) => print('Error: $message'),
      // Callback when an error occurs
      // onPause: () => print('Paused'),
      // Callback when audio is paused
      // onPlay: (isPlaying) => print('Playing: $isPlaying'),
      // Callback when audio starts or resumes playing
      // onSpeedChange: (speed) =>
      //     print('Speed: $speed'), // Callback when playback speed is changed
    );
  }
}
