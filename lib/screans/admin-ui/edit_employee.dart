import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditEmployee extends StatelessWidget {
  EditEmployee({super.key});

  final userStream = FirebaseFirestore.instance.collection("user").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تعديل موظف"),
      ),
    );
  }
}
