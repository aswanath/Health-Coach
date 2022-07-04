import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:health_coach/constants/constants.dart';

BetterPlayerConfiguration playerConfiguration({required String image,List<BetterPlayerOverflowMenuItem> list= const []}) {
  return BetterPlayerConfiguration(
      autoDispose: false,
      showPlaceholderUntilPlay: true,
      useRootNavigator: true,
      placeholder: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      ),
      controlsConfiguration: BetterPlayerControlsConfiguration(
          overflowMenuCustomItems: list,
          enableAudioTracks: false,
          enableQualities: false,
          enableSubtitles: false,
          controlBarColor: Colors.black.withOpacity(.4),
          progressBarPlayedColor: commonGreen,
          progressBarBufferedColor: commonGreen.withOpacity(.5),
          progressBarHandleColor: commonGreen,
          enablePlayPause: false));
}