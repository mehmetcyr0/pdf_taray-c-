import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/scan_provider.dart';

class ExportButton extends StatelessWidget {
  const ExportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ScanProvider>(
      builder: (context, provider, child) {
        if (provider.scannedImages.isEmpty) {
          return const SizedBox.shrink();
        }

        return IconButton(
          icon: provider.isBusy
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              : const Icon(Icons.share),
          onPressed: provider.isBusy
              ? null
              : () async {
                  final pdf = await provider.createPDF();
                  if (context.mounted) {
                    await Share.shareXFiles(
                      [XFile(pdf.path)],
                      subject: 'Taranmış Belge',
                    );
                  }
                },
        );
      },
    );
  }
}