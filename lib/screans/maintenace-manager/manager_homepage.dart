import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sanad_app/screans/navigation-bar/manager_nav_bar.dart';

class ManagerHomepage extends StatefulWidget {
  const ManagerHomepage({super.key});

  @override
  State<ManagerHomepage> createState() => _ManagerHomepageState();
}

class _ManagerHomepageState extends State<ManagerHomepage> {
  late String _firstName = '';
  late String _lastName = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Access the "users" collection in Firestore
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      // Retrieve first and last name from the document
      setState(() {
        _firstName = userData['firstName'] ?? '';
        _lastName = userData['lastName'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 249, 252, 1),
      appBar: AppBar(
        elevation: 0.2,
        shadowColor: Colors.grey,
        toolbarHeight: 90,
        backgroundColor: const Color(0xffFDFDFD),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              print("object");
            },
            child: CircleAvatar(
              radius: 35.0,
              backgroundImage: AssetImage("images/تنزيل (3).jpeg"),
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome,',
              style: GoogleFonts.nunitoSans(
                color: const Color.fromARGB(255, 85, 85, 85),
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              '$_firstName $_lastName',
              style: GoogleFonts.nunitoSans(
                color: const Color.fromARGB(255, 59, 59, 61),
                fontSize: 17,
                fontWeight: FontWeight.w900,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const ManagerNBar(),
      body: SingleChildScrollView(
        child: Column(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "الخدمات",
                style: GoogleFonts.nunitoSans(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                serviceButton(
                  icon: Icons.category,
                  title: " تصفح الطلبات",
                  subTitle: "تصفح احدث البلاغات المرفوعة",
                  routeName: "/m_request_list",
                ),
                Divider(),
                serviceButton(
                  icon: Icons.location_on,
                  title: " اضافة موظف",
                  subTitle: "اضافة موظف الى قسم",
                  routeName: "/manager_add_employee",
                ),
                Divider(),
                serviceButton(
                  icon: Icons.people,
                  title: "الموظفين",
                  subTitle: "رؤية معلومات الموظفين",
                  routeName: "/manager_change_available",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget serviceButton({
    required IconData icon,
    required String title,
    required String subTitle,
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
              color: Color(0xffFDFDFD)),
          child: Card(
            elevation: 0,
            child: ListTile(
              leading: Container(
                  color: Colors.grey[300],
                  child: Icon(
                    icon,
                    size: 50,
                    color: Color.fromARGB(255, 15, 93, 156),
                  )),
              title: Text(
                title,
                style: GoogleFonts.nunitoSans(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.start,
              ),
              subtitle: Text(
                subTitle,
                style: GoogleFonts.nunitoSans(
                  color: Colors.grey[500],
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
