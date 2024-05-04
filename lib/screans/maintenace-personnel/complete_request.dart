import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompleteRequestPage extends StatefulWidget {
  final String requestId;
  final String userId;

  const CompleteRequestPage({required this.requestId, required this.userId});

  @override
  _CompleteRequestPageState createState() => _CompleteRequestPageState();
}

class _CompleteRequestPageState extends State<CompleteRequestPage> {
  final TextEditingController _commentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  String? _imageUrl;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });

      var imageName = image.name;
      var refStorage = FirebaseStorage.instance.ref('completed-pic/$imageName');

      try {
        await refStorage.putFile(_imageFile!);
        String downloadUrl = await refStorage.getDownloadURL();

        setState(() {
          _imageUrl = downloadUrl;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading image: $e')),
        );
      }
    }
  }

  Future<void> _completeRequest() async {
    if (_imageFile == null || _commentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please complete the form before submitting.')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('requests')
          .doc(widget.requestId)
          .update({
        'state': 'completed',
        'completionImageUrl': _imageUrl,
        'completionComment': _commentController.text.trim(),
      });

      // Optionally, notify the user via email or other means
      // For example:
      // await sendEmailNotification(widget.userId, _commentController.text.trim(), _imageUrl);

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request completed successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error completing request: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complete Request"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _imageFile != null
                    ? Image.file(_imageFile!, fit: BoxFit.cover)
                    : Icon(Icons.camera_alt, size: 50, color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: "Comment",
                hintText: "Add a comment for the user",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _completeRequest,
              child: Text("Complete Request"),
            ),
          ],
        ),
      ),
    );
  }
}
