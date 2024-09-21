import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class TicketScanner extends StatefulWidget {
  const TicketScanner({Key? key}) : super(key: key);

  @override
  _TicketScannerState createState() => _TicketScannerState();
}

class _TicketScannerState extends State<TicketScanner> {
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Scanner'),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue[300],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[100]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: _image == null
                  ? Center(child: Text('No image selected.'))
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(_image!),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildScanOption(
                    context: context,
                    title: 'Camera',
                    icon: Icons.camera_alt,
                    onPressed: () => _pickImage(ImageSource.camera),
                  ),
                  _buildScanOption(
                    context: context,
                    title: 'Gallery',
                    icon: Icons.photo_library,
                    onPressed: () => _pickImage(ImageSource.gallery),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScanOption({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            backgroundColor: Colors.blue[300],
            elevation: 5,
          ),
          child: Icon(
            icon,
            size: 30,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: Colors.blue[800],
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
