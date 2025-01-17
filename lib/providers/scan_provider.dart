import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:image/image.dart' as img;

class ScanProvider with ChangeNotifier {
  final List<File> _scannedImages = [];
  bool _isBusy = false;

  List<File> get scannedImages => _scannedImages;
  bool get isBusy => _isBusy;

  void addImage(File image) {
    _scannedImages.add(image);
    notifyListeners();
  }

  void removeImage(int index) {
    _scannedImages.removeAt(index);
    notifyListeners();
  }

  void clearImages() {
    _scannedImages.clear();
    notifyListeners();
  }

  Future<File> createPDF() async {
    _isBusy = true;
    notifyListeners();

    try {
      final pdf = pw.Document();

      for (var imageFile in _scannedImages) {
        final image = img.decodeImage(await imageFile.readAsBytes());
        if (image != null) {
          final pdfImage = pw.MemoryImage(
            img.encodeJpg(image, quality: 85),
          );

          pdf.addPage(
            pw.Page(
              build: (context) => pw.Center(
                child: pw.Image(pdfImage),
              ),
            ),
          );
        }
      }

      final output = await getTemporaryDirectory();
      final file = File(
          '${output.path}/tarama_${DateTime.now().millisecondsSinceEpoch}.pdf');
      await file.writeAsBytes(await pdf.save());

      return file;
    } finally {
      _isBusy = false;
      notifyListeners();
    }
  }
}
