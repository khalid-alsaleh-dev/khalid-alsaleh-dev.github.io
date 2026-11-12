import 'package:flutter/material.dart';

class PrototypeVideo extends StatelessWidget {
  const PrototypeVideo({super.key, required this.path, required this.speed});
  final String path;
  final double speed;
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text('Video preview available on the website'));
}
