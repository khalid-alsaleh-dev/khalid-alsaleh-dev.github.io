import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

class PrototypeVideo extends StatelessWidget {
  const PrototypeVideo({super.key, required this.path, required this.speed});
  final String path;
  final double speed;

  @override
  Widget build(BuildContext context) => HtmlElementView.fromTagName(
    tagName: 'video',
    onElementCreated: (element) {
      final video = element as web.HTMLVideoElement;
      video
        ..src = Uri.base.resolve(path).toString()
        ..poster = Uri.base
            .resolve(
              path
                  .replaceFirst('videos/', 'videos/posters/')
                  .replaceAll('.mp4', '.jpg'),
            )
            .toString()
        ..controls = true
        ..preload = 'metadata'
        ..playbackRate = speed
        ..defaultPlaybackRate = speed
        ..setAttribute('playsinline', '')
        ..setAttribute('aria-label', 'Prototype video');
      video.style
        ..width = '100%'
        ..height = '100%'
        ..objectFit = 'cover'
        ..backgroundColor = '#10131b';
    },
  );
}
