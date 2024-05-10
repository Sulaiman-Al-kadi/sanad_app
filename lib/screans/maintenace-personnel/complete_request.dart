import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sanad_app/screans/maintenace-personnel/mp_homepage.dart';

class CompleteRequestPage extends StatefulWidget {
  final String requestId;
  final String userId;

  const CompleteRequestPage(
      {required this.requestId, required this.userId, Key? key})
      : super(key: key);

  @override
  _CompleteRequestPageState createState() => _CompleteRequestPageState();
}

class _CompleteRequestPageState extends State<CompleteRequestPage> {
  final TextEditingController _commentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  String? _imageUrl;
  bool _isUploadingImage = false;

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
        print('Error uploading image: $e');
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image: $e')),
      );
    }
  }

  Future<void> _completeRequest() async {
    if (_imageFile == null || _commentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('.الرجاء تعبئة حميع البيانات المطلوبة')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('requests')
          .doc(widget.requestId)
          .update({
        'state': 'completed',
        'mpImage': _imageUrl,
        'mpComment': _commentController.text.trim(),
      });

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MPHomepage()), // Replace MainPage() with your main page widget
        (route) => false,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Text('!تم انهاء الطلب بنجاح'),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ:')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("استكمال الطلب"),
      ),
      body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("فضلا قم بتحميل صورة للعمل المنجز",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: getImage,
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 340,
                                  width: 340,
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 67),
                        Container(
                          margin: EdgeInsets.only(left: 30, right: 15),
                          child: TextField(
                            controller: _commentController,
                            decoration: InputDecoration(
                              labelText: "أدخل تعليقك هنا",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    width: 2),
                              ),
                            ),
                            maxLines: 3,
                          ),
                        ),
                        SizedBox(height: 67),
                        MaterialButton(
                          minWidth: double.maxFinite,
                          onPressed: _completeRequest,
                          colorBrightness: Brightness.light,
                          elevation: 2.0,
                          splashColor: Colors.blue,
                          color: Color.fromARGB(255, 25, 59, 77),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 50),
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0), width: 1),
                          ),
                          child: Text(
                            'انهاء الطلب',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ])))),
    );
  }
}
