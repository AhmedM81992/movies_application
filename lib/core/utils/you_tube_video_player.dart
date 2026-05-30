import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:movies_app/core/utils/size_config.dart';
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

  final List<double> _playbackSpeeds = [0.25, 0.5, 1.0, 1.5, 2.0];
  double _currentSpeed = 1.0;

  // Zoom support
  final TransformationController _tx = TransformationController();
  // Optional: double-tap zoom target
  final double _doubleTapZoom = 2.0;

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
          useHybridComposition: true, // helps with gestures on Android
        ),
      );
    }
  }

  // Helper to seek relative seconds (negative for backward, positive for forward)
  void _seekRelative(int seconds) {
    final controller = _controller;
    if (controller == null) return;
    final current = controller.value.position;
    final metaDuration = controller.metadata.duration;
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
    _tx.dispose();
    super.dispose();
  }

  // Reset zoom back to 1x (e.g., after gesture end if slightly under 1x)
  void _ensureNonShrunk() {
    final m = _tx.value;
    if (m.storage[0] < 1.0) {
      // scaleX < 1 means it's shrunk; reset to identity
      _tx.value = Matrix4.identity();
    }
  }

  // Double tap toggles between 1x and preset zoom (centered where tapped)
  void _onDoubleTapDown(TapDownDetails d, BoxConstraints constraints) {
    final currentScale = _tx.value.storage[0];
    if (currentScale > 1.01) {
      _tx.value = Matrix4.identity();
      return;
    }
    // Zoom in around the tap point
    final tap = d.localPosition;
    final scale = _doubleTapZoom;
    final dx = -tap.dx * (scale - 1);
    final dy = -tap.dy * (scale - 1);
    _tx.value = Matrix4.identity()
      ..translate(dx, dy)
      ..scale(scale);
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return const Center(
        child: Text('Invalid YouTube URL', style: TextStyle(color: Colors.red)),
      );
    }

    final player = YoutubePlayer(
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
        SizeConfig.horizontalSpace(8),
        const Expanded(
          child: ProgressBar(
            isExpanded: true,
            colors: ProgressBarColors(
              playedColor: Colors.redAccent,
              handleColor: Colors.redAccent,
            ),
          ),
        ),
        SizeConfig.horizontalSpace(8),
        const RemainingDuration(),
        IconButton(
          tooltip: 'Forward 10s',
          icon: const Icon(Icons.forward_10, color: Colors.white),
          onPressed: () => _seekRelative(10),
        ),
        DropdownButton<double>(
          value: _currentSpeed,
          dropdownColor: Colors.black87,
          underline: const SizedBox(),
          style: const TextStyle(color: Colors.white),
          icon: const Icon(Icons.speed, color: Colors.white),
          items: _playbackSpeeds
              .map((s) => DropdownMenuItem<double>(
                    value: s,
                    child: Text('${s}x'),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() => _currentSpeed =
                  value); // BRAIN_EXCEPTION: local UI-only video playback state
              _controller?.setPlaybackRate(value);
            }
          },
        ),
        const FullScreenButton(),
      ],
    );

    return SafeArea(
      child: YoutubePlayerBuilder(
        player: player,
        builder: (context, builtPlayer) {
          // Wrap the player in an InteractiveViewer to enable pinch zoom + pan.
          return LayoutBuilder(
            builder: (context, constraints) {
              return GestureDetector(
                // double-tap to zoom
                onDoubleTapDown: (d) => _onDoubleTapDown(d, constraints),
                onDoubleTap: () {}, // required to pair with onDoubleTapDown
                child: InteractiveViewer(
                  transformationController: _tx,
                  maxScale: 4.0, // you can raise this if you want more zoom
                  minScale: 1.0, // keep 1x as the floor so controls aren’t tiny
                  panEnabled: true,
                  scaleEnabled: true,
                  clipBehavior: Clip.none,
                  boundaryMargin: const EdgeInsets.all(32),
                  onInteractionEnd: (_) => _ensureNonShrunk(),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: builtPlayer,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
