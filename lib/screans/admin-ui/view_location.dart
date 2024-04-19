import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class LocationData extends StatelessWidget {
  LocationData({Key? key}) : super(key: key);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('عرض المواقع'),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('location').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final documents = snapshot.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final document = documents[index];
                final building = document['building'];
                final floor = document['floor'];
                final qrCode = document['qrCode'];
                final room = document['room'];
                final suite = document['suite'];

                return Column(
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.memory(
                        base64Decode(
                            qrCode), // Decode base64-encoded QR code data
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Building: $building'),
                    Text('Floor: $floor'),
                    Text('Room: $room'),
                    Text('Suite: $suite'),
                    SizedBox(height: 20),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
