import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EnhancedRequestPage extends StatefulWidget {
  final String? building;
  final String? floor;
  final String? suit;
  final String? room;

  const EnhancedRequestPage({
    Key? key,
    this.building,
    this.floor,
    this.suit,
    this.room,
  }) : super(key: key);

  @override
  _EnhancedRequestPageState createState() => _EnhancedRequestPageState();
}

class _EnhancedRequestPageState extends State<EnhancedRequestPage> {
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? file;
  String? url;
  String? _selectedCategory;
  String? _selectedEntity;
  List<String> _categories = [];
  List<String> _entities = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    final categories = await FirebaseFirestore.instance
        .collection('category')
        .get()
        .then((querySnapshot) =>
            querySnapshot.docs.map((doc) => doc['name'] as String).toList());
    setState(() {
      _categories = categories;
    });
  }

  Future<void> _fetchEntities(String category) async {
    final entities = await FirebaseFirestore.instance
        .collection('entity')
        .where('category', isEqualTo: category)
        .get()
        .then((querySnapshot) =>
            querySnapshot.docs.map((doc) => doc['name'] as String).toList());
    setState(() {
      _entities = entities;
    });
  }

  Future<void> getImage() async {
    final XFile? imageCamera =
        await _picker.pickImage(source: ImageSource.camera);

    if (imageCamera != null) {
      setState(() {
        file = File(imageCamera.path);
      });

      var imageName = imageCamera.name;
      var refStorage = FirebaseStorage.instance.ref('request-pic/$imageName');

      try {
        await refStorage.putFile(file!);
        url = await refStorage.getDownloadURL();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading image: $e')),
        );
      }
    }
  }

  Future<void> saveRequest() async {
    if (url == null || _selectedCategory == null || _selectedEntity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please complete the form before submitting.')),
      );
      return;
    }

    await FirebaseFirestore.instance.collection('requests').add({
      'category': _selectedCategory,
      'entity': _selectedEntity,
      'image_url': url,
      'description': _descriptionController.text.trim(),
      'building': widget.building,
      'floor': widget.floor,
      'suit': widget.suit,
      'room': widget.room,
      'timestamp': FieldValue.serverTimestamp(),
    });

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Request submitted successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enhanced User Request"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            DropdownButton<String>(
              value: _selectedCategory,
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                  _fetchEntities(newValue);
                });
              },
              items: _categories.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text('Select Category'),
            ),
            if (_entities.isNotEmpty)
              DropdownButton<String>(
                value: _selectedEntity,
                onChanged: (newValue) {
                  setState(() {
                    _selectedEntity = newValue!;
                  });
                },
                items: _entities.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: Text('Select Entity'),
              ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: getImage,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: url != null
                    ? Image.network(url!, fit: BoxFit.cover, height: 200)
                    : Icon(Icons.camera_alt, size: 50, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
                hintText: "Enter a description of the issue",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveRequest,
              child: Text("Submit Request"),
            ),
          ],
        ),
      ),
    );
  }
}
