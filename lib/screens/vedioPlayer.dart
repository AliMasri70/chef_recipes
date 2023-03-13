import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerPopup extends StatefulWidget {
  VideoPlayerPopup({required this.videoUrl});
  String videoUrl;
  @override
  _VideoPlayerPopupState createState() => _VideoPlayerPopupState();
}

class _VideoPlayerPopupState extends State<VideoPlayerPopup> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;
  var videoId;
  @override
  void initState() {
    super.initState();

    videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    _controller = YoutubePlayerController(
        initialVideoId: videoId == null ? "" : videoId,
        flags: YoutubePlayerFlags(
            mute: false,
            autoPlay: true,
            disableDragSeek: false,
            loop: false,
            isLive: false,
            forceHD: false,
            enableCaption: true));
    _controller = YoutubePlayerController(
      initialVideoId: videoId == null ? "" : videoId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    double _playerHeight = 200;
    double _playerWidth = 400;
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      content: Container(
        height: _playerHeight,
        width: _playerWidth,
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          onReady: () {
            setState(() {
              _isPlayerReady = true;
            });
          },
          onEnded: (data) {
            _controller.dispose();
            _isPlayerReady = false;
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
