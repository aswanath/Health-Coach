import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:health_coach/constants/constants.dart';

class VideoPlayerCustom extends StatefulWidget {
  final BetterPlayerDataSource betterPlayerDataSource;
  final bool looping;
  final bool autoplay;
  final String imageLink;

  VideoPlayerCustom({Key? key,
    required this.betterPlayerDataSource,
    this.autoplay = true,
    required this.imageLink,
    this.looping = false})
      : super(key: key);

  @override
  State<VideoPlayerCustom> createState() => _VideoPlayerCustomState();
}

class _VideoPlayerCustomState extends State<VideoPlayerCustom> {
  late BetterPlayerController _controller;
  late BetterPlayerConfiguration _configuration;

  @override
  initState() {
    super.initState();
    _configuration = BetterPlayerConfiguration(
        autoPlay: widget.autoplay,
        looping: widget.looping,
        useRootNavigator: true,
        fullScreenByDefault: true,
        placeholder: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            widget.imageLink,
            fit: BoxFit.cover,
          ),
        ),
        controlsConfiguration: BetterPlayerControlsConfiguration(
          controlBarColor: Colors.black.withOpacity(.4),
          progressBarPlayedColor: commonGreen,
          progressBarBufferedColor: commonGreen.withOpacity(.5),
          progressBarHandleColor: commonGreen,
          enableFullscreen: false,
          showControlsOnInitialize: false
        )
    );
    _controller = BetterPlayerController(
        _configuration, betterPlayerDataSource: widget.betterPlayerDataSource);
  }

  @override
  dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor:Colors.transparent,body: BetterPlayer(controller: _controller,));
  }
}