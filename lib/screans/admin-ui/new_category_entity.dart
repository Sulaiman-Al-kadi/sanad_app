import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as Path;


class CategoryAndEntity extends StatelessWidget {
  const CategoryAndEntity({Key? key});

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

          miniServiceButton(
            context: context,
            icon: Icons.file_copy,
            title:"تعديل مسمى التصنيف و الفئة",
            routeName: "/admin_add_category",
          ),
          Divider(),
          miniServiceButton(
            context: context,
            icon: Icons.file_copy,
            title: "اضافة تصنيف او فئة",
            routeName: "/admin_add_entity",

          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            onPressed: () {
              Navigator.of(context).pushNamed("/delete_category_entity");
            },
            color: Colors.blue,
            child: Text("حذف تصنيف او فئة",
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

  Widget miniServiceButton({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String routeName,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(routeName);
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(15),
            color: Color(0xffFDFDFD),
          ),
          child: Card(
            elevation: 0,
            child: ListTile(
              leading: Container(
                color: Colors.grey[300],
                child: Icon(
                  icon,
                  size: 50,
                  color: Color.fromARGB(255, 15, 93, 156),
                ),
              ),
              title: Text(
                title,
                style: GoogleFonts.nunitoSans(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.start,
              ),
              trailing: Icon(Icons.keyboard_arrow_right_outlined),
            ),
          ),
        ),
      ),
    );
  }
}
