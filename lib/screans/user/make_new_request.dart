import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  getImage() {}
}

class _EnhancedRequestPageState extends State<EnhancedRequestPage> {
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  String? _imageUrl;
  String? _selectedCategory;
  String? _selectedEntity;
  List<String> _categories = [];
  List<String> _entities = [];
  bool _isLoadingEntities = false;
  bool _isUploadingImage = false;
  String? mpEmail;

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
    setState(() {
      _isLoadingEntities = true;
    });
    final entities = await FirebaseFirestore.instance
        .collection('entity')
        .where('category', isEqualTo: category)
        .get()
        .then((querySnapshot) =>
            querySnapshot.docs.map((doc) => doc['name'] as String).toList());
    setState(() {
      _entities = entities;
      _isLoadingEntities = false;
    });
  }

  Future<void> getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
      await _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) return;

    setState(() {
      _isUploadingImage = true;
    });

    try {
      var imageName = _imageFile!.path.split('/').last;
      var refStorage = FirebaseStorage.instance.ref('request-pic/$imageName');

      await refStorage.putFile(_imageFile!);
      String imageUrl = await refStorage.getDownloadURL();
      setState(() {
        _imageUrl = imageUrl;
        _isUploadingImage = false;
      });
    } catch (e) {
      setState(() {
        _isUploadingImage = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ اثنائ رفخ الصورة: $e')),
      );
    }
  }

  // This function will fetch the maintenance personnel with the minimum requests
  Future<String> assignedTo() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Fetch the department based on selected entity and category
      QuerySnapshot department = await firestore
          .collection('entity')
          .where('name', isEqualTo: _selectedEntity)
          .where('category', isEqualTo: _selectedCategory)
          .get();

      // Assuming only one department matches the criteria
      if (department.docs.isNotEmpty) {
        String departmentId = department.docs.first.get('department');

        // Fetch all maintenance personnel and managers who are available and belong to the fetched department
        QuerySnapshot personnelSnapshot = await firestore
            .collection('users')
            .where('available', isEqualTo: true)
            .where('userType', whereIn: ['Maintenance Personnel', 'Manager'])
            .where('department', isEqualTo: departmentId)
            .get();

        String emailWithMinRequests = '';
        int minNumberOfRequests = -1;

        // Iterate over each personnel to count their assigned requests
        for (var doc in personnelSnapshot.docs) {
          String email = doc.get('email');

          // Count requests for this personnel
          QuerySnapshot requestSnapshot = await firestore
              .collection('requests')
              .where("assignedTo", isEqualTo: email)
              .get();

          int numberOfRequests = requestSnapshot.size;

          // Check if this personnel has fewer requests than the current minimum
          if (minNumberOfRequests == -1 ||
              numberOfRequests < minNumberOfRequests) {
            minNumberOfRequests = numberOfRequests;
            emailWithMinRequests = email;
          }
        }

        return emailWithMinRequests;
      } else {
        // Handle if no department is found
        print('No department found for the selected entity and category');
        return '';
      }
    } catch (e) {
      // Handle any errors appropriately
      print('Error fetching maintenance personnel with minimum requests: $e');
      return '';
    }
  }

  Future<String> fetchDept() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('entity')
        .where('name', isEqualTo: _selectedEntity)
        .get();

    if (snapshot.docs.isNotEmpty) {
      var department = snapshot.docs.first.data()['department'];
      return department;
    } else {
      return ''; // or any default value you prefer
    }
  }

  Future<void> _saveRequest() async {
    if (_imageUrl == null ||
        _selectedCategory == null ||
        _selectedEntity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('الرجاء ادخال البيانات المطلوبة')),
      );
      return;
    }

    User? user = FirebaseAuth.instance.currentUser;
    String? email = user?.email;

    mpEmail = await assignedTo() as String?;
    var h = await fetchDept() as String?;
    try {
      await FirebaseFirestore.instance.collection('requests').add({
        'category': _selectedCategory,
        'entity': _selectedEntity,
        'image_url': _imageUrl,
        'description': _descriptionController.text.trim(),
        'building': widget.building,
        'floor': widget.floor,
        'suit': widget.suit,
        'room': widget.room,
        'timestamp': FieldValue.serverTimestamp(),
        'state': 'onProgress',
        'assignedTo': mpEmail,
        'email': email,
        'rate': 0,
        'mpComment': 'null',
        'mpImage': 'null',
        'userFeedback': 'null',
        'department': h
      });

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'تم ارسال الطلب بنجاح',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 54, 244, 82),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ :$e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("املأ البيانات لارسال الطلب"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Text(" مانوع المشكلة؟ أختر من القائمة ادناه"),
            DropdownButton<String>(
              value: _selectedCategory,
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                  _selectedEntity = null;
                  _fetchEntities(newValue);
                });
              },
              items: _categories.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text( 'اختر التصنيف'),
              icon: Icon(Icons.arrow_drop_down),
              elevation: 16,
              style: TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                width: 100,
                color: Colors.blue,
              ),
            ),
            Text("ماهي المشكلة تحديدا ؟ اختر من القائمة ادناه"),
            SizedBox(height: 20),
            if (_isLoadingEntities)
              CircularProgressIndicator()
            else if (_entities.isNotEmpty)
              DropdownButton<String>(
                value: _selectedEntity,
                onChanged: (newValue) {
                  setState(() {
                    _selectedEntity = newValue;
                  });
                },
                items: _entities.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: Text('اختر الئة'),
                icon: Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  width: 100,
                  color: Colors.blue,
                ),
              ),
            SizedBox(height: 20),
            Text("فضلا قم بأخذ صورة للمشكلة لتسهيل عملية الصيانة *"),
            GestureDetector(
              onTap: getImage,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 400,
                      width: 400,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: _imageUrl != null
                          ? Image.network(_imageUrl!,
                              fit: BoxFit.fill, height: 400)
                          : Icon(Icons.camera_alt,
                              size: 50, color: Colors.grey),
                    ),
                  ),
                  if (_isUploadingImage)
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
            SizedBox(height: 20),
            TextField(
              maxLength: 149,
              maxLengthEnforcement: MaxLengthEnforcement
                  .enforced, // This will prevent further input once the limit is reached
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: "اختياري: الوصف",
                hintText:
                    "مثال :الافياش الكهربائية لا تعمل رجاءا تصليحها بأسرع وقت ممكن",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                _saveRequest();
              },
              icon: Icon(Icons.send),
              label: Text("ارسال الطلب"),
            ),
          ],
        ),
      ),
    );
  }
}
