import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final VideoPlayerController? videoController;

  const VideoWidget({
    Key? key,
    required this.videoController,
  }) : super(key: key);

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).video,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorSchemes.black,
                letterSpacing: -0.24,
                fontSize: 16,
              ),
        ),
        const SizedBox(
          height: 16,
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              height: 180,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16), color: Colors.red),
              child: AspectRatio(
                aspectRatio: widget.videoController!.value.aspectRatio * 2,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    VideoPlayer(
                      widget.videoController!,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        widget.videoController!.value.isPlaying
                            ? widget.videoController!.pause()
                            : widget.videoController!.play();
                        setState(() {});
                      },
                      child: Stack(
                        children: <Widget>[
                          _buildPlay(),
                          Positioned(
                              left: 8,
                              bottom: 28,
                              child: StreamBuilder<String>(
                                  stream: getVideoPosition(),
                                  builder: (context, snapshot) {
                                    return Text(snapshot.data ?? "");
                                  })),
                          Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Row(
                                children: [
                                  Expanded(child: _buildIndicator()),
                                  const SizedBox(width: 12),
                                  const SizedBox(width: 8),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Stream<String> getVideoPosition() async* {
    while (widget.videoController!.value.isPlaying) {
      final duration = Duration(
          milliseconds:
              widget.videoController!.value.position.inMilliseconds.round());
      yield [duration.inMinutes, duration.inSeconds]
          .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
          .join(':');
      await Future.delayed(const Duration(seconds: 1));
    }

    final duration = Duration(
        milliseconds:
            widget.videoController!.value.position.inMilliseconds.round());
    yield [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  Widget _buildIndicator() => Container(
        margin: const EdgeInsets.all(8).copyWith(right: 0),
        height: 16,
        child: VideoProgressIndicator(
          widget.videoController!,
          allowScrubbing: true,
        ),
      );

  Widget _buildPlay() => AnimatedSwitcher(
        duration: const Duration(milliseconds: 50),
        reverseDuration: const Duration(milliseconds: 200),
        child: Container(
          color: Colors.black26,
          child: Center(
            child: SvgPicture.asset(
              fit: BoxFit.scaleDown,
              _isPlayIcon(widget.videoController!.value.isPlaying),
              width: 60,
              height: 60,
            ),
          ),
        ),
      );

  String _isPlayIcon(bool isPlaying) {
    if (isPlaying) {
      setState(() {});
      return ImagePaths.pause;
    } else {
      setState(() {});
      return ImagePaths.play;
    }
  }
}
