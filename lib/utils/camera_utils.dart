import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/scan_provider.dart';

class CameraUtils {
  static Future<void> takePicture(
    BuildContext context,
    CameraController controller,
  ) async {
    try {
      final image = await controller.takePicture();
      if (context.mounted) {
        context.read<ScanProvider>().addImage(File(image.path));
        Navigator.pop(context);
      }
    } catch (e) {
      debugPrint('Error taking picture: $e');
    }
  }
}