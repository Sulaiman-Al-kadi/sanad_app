import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sanad_app/screans/maintenace-personnel/Finshed_requests.dart';
import 'package:sanad_app/screans/maintenace-personnel/in_progress_Requests.dart';
import 'package:sanad_app/screans/navigation-bar/maintenace_nav_bar.dart';
import 'package:sanad_app/screans/user/user_finished.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late String _firstName = '';
  late String _lastName = '';

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
  void initState() {
    super.initState();
    _loadUserData();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.grey,
        toolbarHeight: 90,
        backgroundColor: const Color(0xffFDFDFD),
        leading: IconButton(
          padding: const EdgeInsets.all(10),
          onPressed: () {},
          icon: const Icon(Icons.notifications_none),
          iconSize: 37,
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
                child: Text('تم الانتهاء',
                    style: GoogleFonts.nunitoSans(
                      color: const Color.fromARGB(255, 59, 59, 61),
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ))),
            Tab(
              child: Text('تحت الصيانه',
                  style: GoogleFonts.nunitoSans(
                    color: const Color.fromARGB(255, 59, 59, 61),
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  )),
            ),
          ],
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  'مرحبا',
                  style: GoogleFonts.nunitoSans(
                    color: const Color.fromARGB(255, 85, 85, 85),
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text('$_firstName $_lastName',
                    style: GoogleFonts.nunitoSans(
                      color: const Color.fromARGB(255, 59, 59, 61),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    )),
              )
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: const CircleAvatar(
              radius: 35.0,
              backgroundImage: AssetImage("images/تنزيل (3).jpeg"),
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [UserFinished(), InprogressPage()],
      ),
    );
  }
}
