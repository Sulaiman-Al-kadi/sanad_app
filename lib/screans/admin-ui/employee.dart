import 'package:flutter/material.dart';

class Employee extends StatelessWidget {
  const Employee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "الموظفين",
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
              Navigator.of(context).pushNamed("/add_employee");
            },
            color: Colors.blue,
            child: Text("اضافة موظف",
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
            child: Text("تعديل موظف",
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
