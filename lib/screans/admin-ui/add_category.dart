import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sanad_app/screans/admin-ui/admin_home_page.dart';

class AddCategory extends StatelessWidget {
  AddCategory({super.key});
  String? category;
  final _firestorer = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("انشاء تصنيف جديد"), backgroundColor: Colors.blue),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 50),
              TextField(
                onChanged: (value) {
                  category = value;
                },
                decoration: InputDecoration(
                  hintText: 'اسم التصنيف',
                  prefixIcon: Icon(Icons.label_important),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(200),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                      )),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(200),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(200),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                      )),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                elevation: 5.0,
                color: Color.fromARGB(255, 4, 131, 234),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
                // ignore: sort_child_properties_last
                child: const Text(
                  'تسجيل تصنيف جديد',
                  style: TextStyle(
                    color: Color.fromARGB(255, 254, 254, 254),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                onPressed: () async {
                  await _firestorer.collection('category').add({
                    'name': category,
                  });
                  Navigator.of(context).pushNamed("/admin_homepage");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}