import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          miniServiceButton(
            context: context,
            icon: Icons.file_copy,
            title: "اضافة موظف",
            routeName: "/add_employee",
          ),
          SizedBox(
            height: 20,
          ),
          miniServiceButton(
            context: context,
            icon: Icons.file_copy,
            title: "تعديل موظف",
            routeName: "/admin_edit_employee",
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            onPressed: () {
              Navigator.of(context).pushNamed("/view_employee");
            },
            color: Colors.blue,
            child: Text("عرض معلومات الموظف",
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
