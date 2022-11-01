import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_projeck/constant/constant.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key, required this.url});
  final String url;
  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final vidioId = YoutubePlayer.convertUrlToId(widget.url);
    _controller = YoutubePlayerController(
      initialVideoId: vidioId!,
      flags: YoutubePlayerFlags(
        autoPlay: true,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]);
        return true;
      },
      child: Scaffold(
        body: Center(
          child: YoutubePlayer(
            actionsPadding: EdgeInsets.all(8),
            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: () => debugPrint('ready'),
            bottomActions: [
              CurrentPosition(),
              ProgressBar(isExpanded: true),
              FullScreenButton(),
            ],
          ),
        ),
      ),
    );
  }
}
