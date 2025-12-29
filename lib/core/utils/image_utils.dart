import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:nakha/core/extensions/shared_extensions.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ImageUtils {
  /// Pick one or multiple images and automatically convert HEIC → JPEG
  Future<List<File>> pickImagesFromGallery({bool allowMultiple = false}) async {
    final List<File> finalFiles = [];

    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: allowMultiple,
    );

    if (result == null) return finalFiles;

    for (final file in result.files) {
      if (file.path == null) continue;
      final originalFile = File(file.path!);
      final convertedFile = await convertHeicToJpeg(originalFile);
      finalFiles.add(convertedFile ?? originalFile);
    }

    return finalFiles;
  }

  /// Converts a HEIC file to JPEG (returns same file if already supported)
  Future<File?> convertHeicToJpeg(File file) async {
    final isHeic =
        file.path.toLowerCase().endsWith('.heic') ||
        file.path.toLowerCase().endsWith('.heif');

    if (!isHeic) return file;

    try {
      final bytes = await file.readAsBytes();
      final Uint8List jpegBytes = await FlutterImageCompress.compressWithList(
        bytes,
        // format: CompressFormat.jpeg,
        // quality: 95,
      );

      final tempDir = await getTemporaryDirectory();
      final outPath = p.join(
        tempDir.path,
        '${p.basenameWithoutExtension(file.path)}.jpg',
      );

      final outFile = await File(outPath).writeAsBytes(jpegBytes, flush: true);
      return outFile;
    } catch (e) {
      'Error converting HEIC'.showTopErrorToast;
      return null;
    }
  }
}
