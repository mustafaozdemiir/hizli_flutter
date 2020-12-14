import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../modeller/haber.dart';

class YoutubeFullScreen extends StatefulWidget {
  Haber model;

  YoutubeFullScreen(this.model);

  @override
  _YoutubeFullScreenState createState() => _YoutubeFullScreenState();
}

class _YoutubeFullScreenState extends State<YoutubeFullScreen> {
  YoutubePlayerController _controller;
  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(widget.model.youtubeVideoUrl),
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
      ),
    )..addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void listener() {
    if (!_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: YoutubePlayerBuilder(
        builder: (context, player) {
          return player;
        },
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
          progressColors: ProgressBarColors(
              playedColor: Colors.amber, handleColor: Colors.amberAccent),
        ),
      ),
    );
  }
}
