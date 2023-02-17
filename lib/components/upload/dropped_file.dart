import 'dart:html';
import 'dart:typed_data';

class DroppedFile {
  final String name;
  final int bytes;
  final String url;
  final Stream<List<int>> stream;
  final Uint8List data;
  final file;

  const DroppedFile(
      {required this.name,
      required this.bytes,
      required this.url,
      required this.stream,
      required this.data,
      required this.file});

  String get size {
    final kb = bytes / 1024;
    final mb = kb / 1024;

    return mb > 1
        ? '${mb.toStringAsFixed(2)} MB'
        : '${kb.toStringAsFixed(2)} KB';
  }
}
