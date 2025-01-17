import 'package:flutter/material.dart';
import '../widgets/scan_button.dart';
import '../widgets/scanned_images_list.dart';
import '../widgets/export_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Tarayıcı'),
        actions: const [
          ExportButton(),
        ],
      ),
      body: const ScannedImagesList(),
      floatingActionButton: const ScanButton(),
    );
  }
}