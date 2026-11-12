import 'package:flutter/material.dart';

import '../effects/slash_heading.dart';
import '../utils/custom_colors.dart';
import '../utils/launch.dart';
import '../widgets/load_when_near.dart';
import '../widgets/prototype_video.dart';
import '../widgets/section_frame.dart';

/// Interactive experiments, presented separately from client projects.
class Prototypes extends StatelessWidget {
  const Prototypes({super.key});

  @override
  Widget build(BuildContext context) {
    const entries = [
      (
        'Accessible chat',
        'A chat prototype connecting deaf and hearing people.',
        'chat.mp4',
        1.25,
        null,
      ),
      (
        'Drums',
        'A playful digital drums experiment.',
        'drums.mp4',
        1.0,
        'https://github.com/khalid-alsaleh-dev/FlutterDrum',
      ),
      (
        'Car showcase',
        'An interactive way to explore cars.',
        'cars.mp4',
        1.0,
        'https://github.com/khalid-alsaleh-dev/Flutter3DCar',
      ),
    ];
    return SectionFrame(
      maxWidth: 1400,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SlashHeading(eyebrow: 'Experiments', title: 'Prototypes.'),
            const SizedBox(height: 20),
            Text(
              'Ideas that came to life in Flutter, three years ago.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: .72),
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 36),
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth >= 1000
                    ? 3
                    : constraints.maxWidth >= 600
                    ? 2
                    : 1;
                final width =
                    (constraints.maxWidth - (columns - 1) * 24) / columns;
                return Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  children: [
                    for (final (title, description, video, speed, github)
                        in entries)
                      SizedBox(
                        width: width,
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: CustomColors.glass,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: CustomColors.glassBorder),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AspectRatio(
                                aspectRatio: 16 / 9,
                                child: LoadWhenNear(
                                  placeholder: _VideoPoster(
                                    title: title,
                                    icon: switch (video) {
                                      'chat.mp4' => Icons.sign_language_rounded,
                                      'drums.mp4' => Icons.graphic_eq_rounded,
                                      _ => Icons.directions_car_rounded,
                                    },
                                  ),
                                  child: PrototypeVideo(
                                    path: 'videos/$video',
                                    speed: speed,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      description,
                                      style: TextStyle(
                                        color: Colors.white.withValues(
                                          alpha: .7,
                                        ),
                                        height: 1.5,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    if (github != null)
                                      TextButton.icon(
                                        onPressed: () => openUrl(github),
                                        icon: const Icon(Icons.code_rounded),
                                        label: const Text('View on GitHub'),
                                      )
                                    else
                                      Text(
                                        'Private project',
                                        style: TextStyle(
                                          color: Colors.white.withValues(
                                            alpha: .55,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _VideoPoster extends StatelessWidget {
  const _VideoPoster({required this.title, required this.icon});
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      gradient: RadialGradient(
        center: Alignment(0, -0.4),
        radius: 1.1,
        colors: [Color(0xff1b2930), Color(0xff0b0d13)],
      ),
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 12,
          left: 14,
          child: Text(
            'FIELD NOTES  /  2023',
            style: TextStyle(
              color: Colors.white.withValues(alpha: .5),
              fontSize: 10,
              letterSpacing: 2,
            ),
          ),
        ),
        Icon(
          icon,
          size: 54,
          color: CustomColors.primary.withValues(alpha: .82),
        ),
        Positioned(
          bottom: 12,
          right: 14,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.play_circle_outline_rounded,
                color: CustomColors.primary,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                'PLAY $title',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                  letterSpacing: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
