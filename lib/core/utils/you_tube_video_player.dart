import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:async';

class YouTubeVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const YouTubeVideoPlayer({super.key, required this.videoUrl});

  @override
  State<YouTubeVideoPlayer> createState() => _YouTubeVideoPlayerState();
}

class _YouTubeVideoPlayerState extends State<YouTubeVideoPlayer> {
  YoutubePlayerController? _controller;
  Timer? _hideTimer;

  // Inside _YouTubeVideoPlayerState
  final List<double> _playbackSpeeds = [0.25, 0.5, 1.0, 1.5, 2.0];
  double _currentSpeed = 1.0;

  @override
  void initState() {
    super.initState();

    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    if (videoId != null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          enableCaption: false,
          loop: false,
          hideThumbnail: true,
          isLive: false,
          forceHD: true,
          disableDragSeek: false,
          useHybridComposition: true,
        ),
      );
    }
  }

  // Helper to seek relative seconds (negative for backward, positive for forward)
  void _seekRelative(int seconds) {
    final controller = _controller;
    if (controller == null) return;
    final current = controller.value.position;
    final metaDuration =
        controller.metadata.duration; // duration may be zero if unknown yet
    int target = current.inSeconds + seconds;
    if (target < 0) target = 0;
    if (metaDuration != Duration.zero && target > metaDuration.inSeconds) {
      target = metaDuration.inSeconds;
    }
    controller.seekTo(Duration(seconds: target));
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return const Center(
        child: Text('Invalid YouTube URL', style: TextStyle(color: Colors.red)),
      );
    }

    return SafeArea(
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller!,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.redAccent,
          bottomActions: [
            IconButton(
              tooltip: 'Back 10s',
              icon: const Icon(Icons.replay_10, color: Colors.white),
              onPressed: () => _seekRelative(-10),
            ),
            const CurrentPosition(),
            const SizedBox(width: 8),
            Expanded(
              child: ProgressBar(
                isExpanded: true,
                colors: const ProgressBarColors(
                  playedColor: Colors.redAccent,
                  handleColor: Colors.redAccent,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const RemainingDuration(),

            IconButton(
              tooltip: 'Forward 10s',
              icon: const Icon(Icons.forward_10, color: Colors.white),
              onPressed: () => _seekRelative(10),
            ),
            // Playback speed dropdown
            DropdownButton<double>(
              value: _currentSpeed,
              dropdownColor: Colors.black87,
              underline: const SizedBox(),
              style: const TextStyle(color: Colors.white),
              icon: const Icon(Icons.speed, color: Colors.white),
              items: _playbackSpeeds.map((speed) {
                return DropdownMenuItem<double>(
                  value: speed,
                  child: Text('${speed}x'),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _currentSpeed = value);
                  _controller?.setPlaybackRate(value);
                }
              },
            ),

            const FullScreenButton(),
          ],
        ),
        builder: (context, player) {
          return AspectRatio(aspectRatio: 16 / 9, child: player);
        },
      ),
    );
  }
}
