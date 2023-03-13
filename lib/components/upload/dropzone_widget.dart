import 'dart:async';

import 'dart:typed_data';
import 'dart:io';

import 'package:firebase_storage_web/firebase_storage_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:uploadtofirebase/components/constants/background.dart';
import 'package:uploadtofirebase/components/upload/dropped_file.dart';

class DropzoneWidget extends StatefulWidget {
  final ValueChanged<DroppedFile> onDroppedFile;

  const DropzoneWidget({Key? key, required this.onDroppedFile})
      : super(key: key);

  @override
  State<DropzoneWidget> createState() => _DropzoneWidgetState();
}

class _DropzoneWidgetState extends State<DropzoneWidget> {
  late DropzoneViewController controller;
  bool isHighlighted = false;

  @override
  Widget build(BuildContext context) {
    final colorBackground =
        isHighlighted ? const Color.fromARGB(255, 65, 65, 65) : myAppBarColor;

    return Container(
      color: colorBackground,
      child: Stack(
        children: [
          DropzoneView(
              cursor: CursorType.grab, //optional
              onCreated: ((controller) => this.controller = controller),
              onHover: (() => setState(() {
                    isHighlighted = true;
                  })),
              onLeave: (() => setState(() {
                    isHighlighted = false;
                  })),
              onDrop: acceptFile),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.cloud_upload,
                    size: 80, color: Color.fromARGB(255, 80, 200, 255)),
                const Text(
                  'Drop Files',
                  style: TextStyle(
                      color: Color.fromARGB(255, 80, 200, 255), fontSize: 24),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () async {
                    final events = await controller.pickFiles();
                    if (events.isEmpty) return;

                    if (events.isNotEmpty) {
                      acceptFile(events.first);
                    }
                  },
                  icon: const Icon(Icons.search, size: 24),
                  label: const Text('Search Files'),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 0, 174, 255))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future acceptFile(dynamic event) async {
    final name = event.name;
    final bytes = await controller.getFileSize(event);
    final url = await controller.createFileUrl(event);
    final stream = controller.getFileStream(event);
    final data = await controller.getFileData(event);
    final evnt = await event;

    final droppedFile = DroppedFile(
        name: name,
        bytes: bytes,
        url: url,
        stream: stream,
        data: data,
        file: evnt);

    widget.onDroppedFile(droppedFile);
    setState(
      () {
        isHighlighted = false;
      },
    );
    print("------------Data Accepted");
  }

  Future uploadWebImage(event) async {
    final storage = FirebaseStorageWeb(bucket: 'images_web');
    final ref = storage.ref('images_web/firstImage.jpg');
    ref.putFile(event);
  }
}
