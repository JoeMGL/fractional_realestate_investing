import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'dart:typed_data';

class DropzoneWidget extends StatefulWidget {
  final Function(Uint8List fileBytes, String fileName) onFileDropped;

  const DropzoneWidget({Key? key, required this.onFileDropped}) : super(key: key);

  @override
  _DropzoneWidgetState createState() => _DropzoneWidgetState();
}

class _DropzoneWidgetState extends State<DropzoneWidget> {
  late DropzoneViewController _controller;
  String _uploadedFileName = '';
  bool _isFileDropped = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[900],
          ),
          child: DropzoneView(
            onCreated: (controller) {
              _controller = controller;
            },
            onDrop: (file) async {
              setState(() {
                _isFileDropped = true;
                _uploadedFileName = file.name;
              });

              try {
                // Get file data
                final fileBytes = await _controller.getFileData(file);
                widget.onFileDropped(fileBytes, file.name); // Pass file data to parent
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error accessing file: $e')),
                );
              }
            },
            onHover: () {
              setState(() {
                _isFileDropped = true;
              });
            },
            onLeave: () {
              setState(() {
                _isFileDropped = false;
              });
            },
          ),
        ),
        if (!_isFileDropped)
          const Center(
            child: Text(
              'Drag & Drop Image Here',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        if (_isFileDropped)
          Center(
            child: Text(
              _uploadedFileName.isEmpty ? 'Uploading...' : _uploadedFileName,
              style: const TextStyle(color: Colors.green, fontSize: 16),
            ),
          ),
      ],
    );
  }
}
