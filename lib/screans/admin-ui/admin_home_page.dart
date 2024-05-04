import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sanad_app/screans/constants.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      backgroundColor: const Color(0xffF8F9FC),
      appBar: AppBar(
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
              radius: 30.0,
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
        actions: [
          IconButton(
            padding: const EdgeInsets.all(10),
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
            iconSize: 37,
          ),
        ],
      ),
      bottomNavigationBar: Nbar(),
      body: SingleChildScrollView(
        child: Column(
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
                  title: "إدارة التصنيفات",
                  subTitle: "اضافة/حذف او تعديل التصنيفات",
                  routeName: "/admin_category_enitity",
                ),
                serviceButton(
                  icon: Icons.location_on,
                  title: "إدارة المواقع",
                  subTitle: "اضافة/حذف او تعديل المواقع",
                  routeName: "/admin_location",
                ),
                serviceButton(
                  icon: Icons.category,
                  title: "إدارة الاقسام",
                  subTitle: "اضافة/حذف او تعديل الاقسام",
                  routeName: "/admin_department",
                ),
                serviceButton(
                  icon: Icons.person,
                  title: "الموظفين",
                  subTitle: "اضافة/حذف موظفين في االنظام",
                  routeName: "/admin_employee",
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
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue[200],
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: GoogleFonts.nunitoSans(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              subTitle,
              style: GoogleFonts.nunitoSans(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
