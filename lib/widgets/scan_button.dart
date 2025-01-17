import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../screens/camera_screen.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  Future<void> _requestCameraPermission(BuildContext context) async {
    final status = await Permission.camera.request();
    if (status.isGranted && context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CameraScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _requestCameraPermission(context),
      child: const Icon(Icons.camera_alt),
    );
  }
}