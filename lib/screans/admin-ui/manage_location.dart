import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ManageLocation extends StatelessWidget {
  const ManageLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ادارة المواقع",
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
              Navigator.of(context).pushNamed("/add_location");
            },
            color: Colors.blue,
            child: Text("اضافة موقع",
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
              Navigator.of(context).pushNamed("/admin_edit_location");
            },
            color: Colors.blue,
            child: Text("تعديل موقع",
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
              Navigator.of(context).pushNamed("/admin_view_location");
            },
            color: Colors.blue,
            child: Text("QR code عرض ",
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
              Navigator.of(context).pushNamed("/delete_location");
            },
            color: Colors.blue,
            child: Text("حذف موقع ",
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
