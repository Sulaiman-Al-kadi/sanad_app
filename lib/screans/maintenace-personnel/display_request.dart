import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sanad_app/screans/maintenace-personnel/complete_request.dart';
import 'package:sanad_app/screans/maintenace-personnel/in_progress_Requests.dart';
import 'package:intl/intl.dart' as intl;

class RequestDetailsPage extends StatefulWidget {
  final String requestId;
  final Map<String, dynamic> requestData;

  const RequestDetailsPage(
      {Key? key, required this.requestId, required this.requestData})
      : super(key: key);

  @override
  _RequestDetailsPageState createState() => _RequestDetailsPageState();
}

class _RequestDetailsPageState extends State<RequestDetailsPage> {
  void navigateToValidationPage() async {
    final bool completed = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CompleteRequestPage(
                requestId: requestId,
                userId: FirebaseAuth.instance.currentUser!.uid,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 6.2,
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 22,
            shadows: [Shadow(color: Colors.grey, blurRadius: 2)]),
        title: Center(
          child: Text(
            "تفاصيل الطلب",
            style: TextStyle(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Container(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('التصنيف: ${widget.requestData['category']}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Text('الفئة: ${widget.requestData['entity']}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Text('وصف المشكلة:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 3),
                  if (widget.requestData['description'] != "")
                    Text(widget.requestData['description'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))
                  else
                    Text("لا يوجد وصف",
                        style:
                            TextStyle(fontSize: 18, color: Colors.grey[600])),
                  SizedBox(
                    height: 30,
                  ),
                  Text("صورة الطلب:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Scaffold(
                            appBar: AppBar(
                              title: Text("صورة الطلب"),
                            ),
                            body: Center(
                              child: Hero(
                                tag: 'imageHero',
                                child: Image.network(
                                  widget.requestData['image_url'],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'imageHero',
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.network(
                            widget.requestData['image_url'],
                            height: 300,
                            width: 300,
                            fit: BoxFit.fill,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                );
                              }
                            },
                          ),
                          // Add loading indicator here
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text("موقع الطلب: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text("رقم المبنى:",
                              style: TextStyle(
                                fontSize: 18,
                              )),
                          SizedBox(width: 8, height: 8),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.all(15),
                            child: Text(widget.requestData['building'],
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                      SizedBox(width: 8, height: 8),
                      Column(
                        children: [
                          Text("رقم الطابق:",
                              style: TextStyle(
                                fontSize: 18,
                              )),
                          SizedBox(width: 8, height: 8),
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(widget.requestData['floor'],
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                      SizedBox(width: 8, height: 8),
                      Column(
                        children: [
                          Text("رقم الغرفة:",
                              style: TextStyle(
                                fontSize: 18,
                              )),
                          SizedBox(width: 8, height: 8),
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(widget.requestData['room'],
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                      SizedBox(width: 8, height: 8),
                      Column(
                        children: [
                          Text("رقم الجناح:",
                              style: TextStyle(
                                fontSize: 18,
                              )),
                          SizedBox(width: 8, height: 8),
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(widget.requestData['suite'].toString(),
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    'تاريخ الطلب: ${(widget.requestData['timestamp'] as Timestamp).toDate()}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                  SizedBox(height: 40),
                  Center(
                      child: MaterialButton(
                    minWidth: double.maxFinite,
                    onPressed: navigateToValidationPage,
                    colorBrightness: Brightness.light,
                    elevation: 5.0,
                    splashColor: Colors.blue,
                    color: Color.fromARGB(255, 25, 59, 77),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(23),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 253, 253), width: 1),
                    ),
                    child: Text(
                      'استكمال الطلب',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
