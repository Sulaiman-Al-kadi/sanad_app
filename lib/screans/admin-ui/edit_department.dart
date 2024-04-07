import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditDepartment extends StatelessWidget {
  EditDepartment({super.key});

  final _firestorer = FirebaseFirestore.instance;

  void textStreams() async {
    await for (var snapshot
        in _firestorer.collection('department').snapshots()) {
      for (var text in snapshot.docs);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تعديل على القسم'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: _firestorer.collection('department').snapshots(),
                builder: (context, snapshot) {
                  List<Text> depName = [];

                  if (!snapshot.hasData) {
                    
                  }
                  final texts = snapshot.data!.docs;
                  for (var t in texts) {
                    final text = t.get('name');
                    final w = Text(
                      '$text',
                    );
                    depName.add(w);
                  }

                  return Column(
                    children: depName,
                  );
                })
          ],
        ),
      ),
    );
  }
}
