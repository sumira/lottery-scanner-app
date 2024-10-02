import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class TicketScanner extends StatefulWidget {
  const TicketScanner({Key? key}) : super(key: key);

  @override
  _TicketScannerState createState() => _TicketScannerState();
}

class _TicketScannerState extends State<TicketScanner> {
  File? _image;
  bool _isUploading = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image first')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.0.2.2:5000/scan-image'),
      );
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        _image!.path,
      ));
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      developer.log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        _showResponseDialog(responseData);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image uploaded successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to upload image')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  void _showResponseDialog(Map<String, dynamic> responseData) {
    final dateController =
        TextEditingController(text: responseData['data']['date']);
    final drawNoController =
        TextEditingController(text: responseData['data']['draw_no']);
    final numbersController =
        TextEditingController(text: responseData['data']['numbers'].join(', '));
    final doubleChanceController = TextEditingController(
        text: responseData['data']['double_chance'].join(', '));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Scan Result'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: dateController,
                  decoration: InputDecoration(labelText: 'Date'),
                ),
                TextField(
                  controller: drawNoController,
                  decoration: InputDecoration(labelText: 'Draw No'),
                ),
                TextField(
                  controller: numbersController,
                  decoration:
                      InputDecoration(labelText: 'Numbers (comma-separated)'),
                ),
                TextField(
                  controller: doubleChanceController,
                  decoration: InputDecoration(
                      labelText: 'Double Chance (comma-separated)'),
                ),
                Text('File: ${responseData['file']}'),
                Text('Type: ${responseData['type']}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:
                  _isSaving ? CircularProgressIndicator() : Text('Save Ticket'),
              onPressed: _isSaving
                  ? null
                  : () async {
                      setState(() {
                        _isSaving = true;
                      });

                      // Update responseData with edited values
                      responseData['data']['date'] = dateController.text;
                      responseData['data']['draw_no'] = drawNoController.text;
                      responseData['data']['numbers'] = numbersController.text
                          .split(',')
                          .map((e) => e.trim())
                          .toList();
                      responseData['data']['double_chance'] =
                          doubleChanceController.text
                              .split(',')
                              .map((e) => e.trim())
                              .toList();

                      await _saveTicketToFirestore(responseData);
                      setState(() {
                        _isSaving = false;
                      });
                      Navigator.of(context).pop();
                    },
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveTicketToFirestore(Map<String, dynamic> ticketData) async {
    try {
      await FirebaseFirestore.instance.collection('saved_tickets').add({
        'date': ticketData['data']['date'],
        'double_chance': ticketData['data']['double_chance'],
        'draw_no': ticketData['data']['draw_no'],
        'numbers': ticketData['data']['numbers'],
        'file': ticketData['file'],
        'type': ticketData['type'],
        'timestamp': FieldValue.serverTimestamp(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ticket saved successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving ticket: $e')),
      );
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
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                onPressed: _isUploading ? null : _uploadImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[300],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: _isUploading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Upload Image',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
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
