import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import SystemChannels
import 'package:movies_app/core/shared_widgets/app_bar_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FullScreenVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const FullScreenVideoPlayer({required this.videoUrl, super.key});

  @override
  State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    if (videoId != null && videoId.isNotEmpty) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          useHybridComposition: true,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return Column(
        children: [
          // const AppBarWidget(title: ''),
          const Expanded(
            child: Center(
              child: Text(
                'Invalid video URL',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        // const AppBarWidget(title: ''),
        Expanded(
          child: Stack(
            children: [
              Container(
                color: Colors.black,
                child: YoutubePlayer(
                  controller: _controller!,
                  aspectRatio: 16 / 9,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.amber,
                  progressColors: const ProgressBarColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.amberAccent,
                  ),
                  onReady: () {
                    debugPrint('FullScreenVideoPlayer: Player is ready.');
                  },
                  onEnded: (data) {
                    debugPrint('FullScreenVideoPlayer: Video has ended.');
                  },
                ),
              ),
              Positioned(
                top: 40.0,
                left: 10.0,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    // Reset preferred orientations before popping
                    SystemChrome.setPreferredOrientations([
                      DeviceOrientation.portraitUp,
                      DeviceOrientation.portraitDown,
                      DeviceOrientation.landscapeLeft,
                      DeviceOrientation.landscapeRight,
                    ]);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
