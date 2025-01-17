import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/scan_provider.dart';

class ScannedImagesList extends StatelessWidget {
  const ScannedImagesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ScanProvider>(
      builder: (context, provider, child) {
        if (provider.scannedImages.isEmpty) {
          return const Center(
            child: Text('Tarama yapmak için kamera butonuna tıklayın'),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: provider.scannedImages.length,
          itemBuilder: (context, index) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Image.file(
                  provider.scannedImages[index],
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => provider.removeImage(index),
                    color: Colors.white,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}