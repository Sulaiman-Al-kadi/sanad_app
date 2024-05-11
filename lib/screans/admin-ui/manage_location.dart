// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class ManageLocation extends StatelessWidget {
//   const ManageLocation({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "ادارة المواقع",
//           textDirection: TextDirection.rtl,
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           SizedBox(
//             height: 50,
//           ),
//           MaterialButton(
//             padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//             onPressed: () {
//               Navigator.of(context).pushNamed("/add_location");
//             },
//             color: Colors.blue,
//             child: Text("اضافة موقع",
//                 style: TextStyle(color: Colors.white, fontSize: 20)),
//             shape: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(50),
//               borderSide: BorderSide.none,
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           MaterialButton(
//             padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//             onPressed: () {
//               Navigator.of(context).pushNamed("/admin_edit_location");
//             },
//             color: Colors.blue,
//             child: Text("تعديل موقع",
//                 style: TextStyle(color: Colors.white, fontSize: 20)),
//             shape: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(50),
//               borderSide: BorderSide.none,
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           MaterialButton(
//             padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//             onPressed: () {
//               Navigator.of(context).pushNamed("/admin_view_location");
//             },
//             color: Colors.blue,
//             child: Text("QR code عرض ",
//                 style: TextStyle(color: Colors.white, fontSize: 20)),
//             shape: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(50),
//               borderSide: BorderSide.none,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

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
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SizedBox(
            height: 50,
          ),
          miniServiceButton(
            context: context,
            icon: Icons.add_location,
            title: "اضافة موقع",
            routeName: "/add_location",
          ),
          SizedBox(
            height: 20,
          ),
          miniServiceButton(
            context: context,
            icon: Icons.change_circle,
            title: "تعديل موقع",
            routeName: "/admin_edit_location",
          ),
          SizedBox(
            height: 20,
          ),
          miniServiceButton(
            context: context,
            icon: Icons.qr_code,
            title: "QR code عرض ",
            routeName: "/admin_view_location",
          ),
          SizedBox(
            height: 20,
          ),
          miniServiceButton(
            context: context,
            icon: Icons.delete,
            title: "حذف موقع",
            routeName: "/delete_location",
          ),
        ]));
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
        ));
  }
}
