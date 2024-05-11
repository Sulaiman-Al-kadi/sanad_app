import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          miniServiceButton(
            context: context,
            icon: Icons.add_box_outlined,
            title: "اضافة قسم",
            routeName: "/craete_department",
          ),
          SizedBox(
            height: 20,
          ),
          miniServiceButton(
            context: context,
            icon: Icons.compare,
            title: "تعديل قسم",
            routeName: "/edit_depatment",
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
