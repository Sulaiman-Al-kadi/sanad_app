import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryAndEntity extends StatelessWidget {
  const CategoryAndEntity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ادارة التصنيفات",
          textDirection: TextDirection.rtl,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 30,
          ),
          MaterialButton(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            onPressed: () {
              Navigator.of(context).pushNamed("/admin_add_category");
            },
            color: Colors.blue,
            child: Text("اضافة تصنيف",
                style: TextStyle(color: Colors.white, fontSize: 20)),
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          MaterialButton(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            onPressed: () {
              Navigator.of(context).pushNamed("/admin_add_entity");
            },
            color: Colors.blue,
            child: Text("اضافة فئة",
                style: TextStyle(color: Colors.white, fontSize: 20)),
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
