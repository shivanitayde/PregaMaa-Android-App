import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class BabyModelViewer extends StatelessWidget {
  final String modelUrl;

  const BabyModelViewer({super.key, required this.modelUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ModelViewer(
        src: modelUrl,
        alt: "Baby 3D Model",
        autoRotate: true,
        cameraControls: true,
        ar: true,
      ),
    );
  }
}
