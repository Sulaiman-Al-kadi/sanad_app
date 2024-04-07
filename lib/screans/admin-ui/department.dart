import 'package:flutter/material.dart';
import 'package:sanad_app/screans/admin-ui/create_department.dart';
import 'package:sanad_app/screans/admin-ui/edit_department.dart';

class Department extends StatelessWidget {
  const Department({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "الاقسام",
          textDirection: TextDirection.rtl,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 50,
          ),
          MaterialButton(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            onPressed: () {
              Navigator.of(context).pushNamed("/craete_department");
            },
            color: Colors.blue,
            child: Text("اضافة قسم",
                style: TextStyle(color: Colors.white, fontSize: 20)),
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            onPressed: () {
              Navigator.of(context).pushNamed("/edit_depatment");
            },
            color: Colors.blue,
            child: Text("تعديل قسم",
                style: TextStyle(color: Colors.white, fontSize: 20)),
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
          ),
        ],
      ),
    );
  }
}
