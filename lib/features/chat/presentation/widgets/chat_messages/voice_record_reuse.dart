import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/utils/most_used_functions.dart';
import 'package:voice_note_kit/recorder/voice_recorder_widget.dart';

class VoiceRecordReuse extends StatefulWidget {
  const VoiceRecordReuse({super.key, this.onRecordedFilePath});

  final Function(String filePath)? onRecordedFilePath;

  @override
  State<VoiceRecordReuse> createState() => _VoiceRecordReuseState();
}

class _VoiceRecordReuseState extends State<VoiceRecordReuse> {
  File? recordedFile;

  @override
  Widget build(BuildContext context) {
    return VoiceRecorderWidget(
      iconSize: 50,
      // showTimerText: true,
      showSwipeLeftToCancel: false,

      // Optional: Add custom sounds for recording events
      // startSoundAsset: "assets/start_warning.mp3",
      // stopSoundAsset: "assets/start_warning.mp3",
      onStartRecording: () {
        setState(() {
          recordedFile = null;
        });
      },

      // When recording is finished
      onRecorded: (file) {
        setState(() {
          recordedFile = file;
          widget.onRecordedFilePath?.call(file.path);
          MostUsedFunctions.printFullText(
            'Voice recorded file path: ${file.path}',
          );
        });
      },

      /// For Flutter Web
      // onRecordedWeb: (url) {
      //   setState(() {
      //     recordedAudioBlobUrl = url;
      //   });
      // },

      /// When error occurs during recording
      onError: (error) {},

      /// If recording was cancelled
      actionWhenCancel: () {},

      // maxRecordDuration: const Duration(seconds: 60),
      permissionNotGrantedMessage: 'Microphone permission required',
      // cancelDoneText: 'Recording cancelled',
      backgroundColor: AppColors.cPrimary,
    );
  }
}
