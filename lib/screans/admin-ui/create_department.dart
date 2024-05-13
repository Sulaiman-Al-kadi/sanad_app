import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateDepartment extends StatelessWidget {
  CreateDepartment({super.key});
  final TextEditingController _depController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(child: const Text("إنشاء قسم جديد")), backgroundColor: Colors.white),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 50),
                TextField(
                  controller: _depController,
                  decoration: InputDecoration(
                    hintText: 'اسم القسم',
                    prefixIcon: Icon(Icons.business),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                MaterialButton(
                  elevation: 5.0,
                  splashColor: Colors.blue,
                  color: Color.fromARGB(255, 255, 255, 255),
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
                  child: const Text(
                    'تسجيل قسم جديد',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(23),
                    borderSide: BorderSide(color: Color.fromARGB(255, 21, 105, 173)),
                  ),
                  onPressed: () async {
                    if (_depController.text.trim().isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("خطأ"),
                            content: const Text("الرجاء إدخال اسم القسم."),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("حسنًا"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }
                    await _firestore.collection('departments').add({
                      'name': _depController.text.trim(),
                    });
                    Navigator.of(context).pushNamed("/admin_homepage");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
