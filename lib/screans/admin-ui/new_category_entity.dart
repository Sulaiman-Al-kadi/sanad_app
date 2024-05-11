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
            title: "تعديل مسمى التصنيف والفئة",
            routeName: "/admin_add_category",
          ),
          Divider(),
          miniServiceButton(
            context: context,
            icon: Icons.add,
            title: "اضافة التصنيف و الفئة",
            routeName: "/admin_add_entity",
          ),
          Divider(),
          miniServiceButton(
            context: context,
            icon: Icons.delete_forever_outlined,
            title: "حذف التصنيف و الفئة",
            routeName: "/delete_category_entity",
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
