import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class AddEntity extends StatefulWidget {
  const AddEntity({super.key});

  @override
  State<AddEntity> createState() => _AddEntityState();
}

class _AddEntityState extends State<AddEntity> {
  final _firestorer = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('تعديل على القسم'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream: _firestorer.collection('category').snapshots(),
                    builder: (context, snapshot) {
                      List<String> categoryList = [];

                      if (!snapshot.hasData) {}
                      final texts = snapshot.data!.docs;
                      for (var t in texts) {
                        final text = t.get('name');
                        final w = text;
                        categoryList.add(w);
                      }
                      String? selectedItem = categoryList[0];
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Center(
                              child: DropdownButton<String>(
                                value: selectedItem,
                                items: categoryList
                                    .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(
                                          '$e',
                                          style: TextStyle(fontSize: 25),
                                        )))
                                    .toList(),
                                onChanged: (String? v) {
                                  setState(() {
                                    selectedItem = v;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
