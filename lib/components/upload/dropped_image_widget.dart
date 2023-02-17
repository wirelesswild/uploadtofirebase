import 'package:flutter/material.dart';
import 'package:uploadtofirebase/components/upload/dropped_file.dart';

class DroppedFileWidget extends StatelessWidget {
  final DroppedFile? file;

  const DroppedFileWidget({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildImage(),
        if (file != null) buildFileDetails(file!),
      ],
    );
  }

  Widget buildImage() {
    if (file == null) return buildEmptyFile('No File');

    return Image.network(
      file!.url,
      width: 360,
      height: 360,
      fit: BoxFit.cover,
      errorBuilder: (context, error, _) => buildEmptyFile('No Preview'),
    );
  }

  Widget buildEmptyFile(String text) {
    return Container(
      width: 240,
      height: 240,
      color: Color.fromARGB(255, 0, 174, 255),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }

  Widget buildFileDetails(DroppedFile file) {
    final style = TextStyle(color: Colors.white, fontSize: 20);

    return Container(
      margin: EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(file.name, style: style),
          const SizedBox(height: 8),
          Text(file.size, style: style)
        ],
      ),
    );
  }
}
