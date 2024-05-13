import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sanad_app/screans/maintenace-manager/manager_inprogress.dart';
import 'package:sanad_app/screans/maintenace-manager/review_request.dart';
import 'package:sanad_app/screans/maintenace-personnel/Finshed_requests.dart';


class RequestListPage extends StatefulWidget {
  const RequestListPage({super.key});

  @override
  State<RequestListPage> createState() => _RequestListPageState();
}

class _RequestListPageState extends State<RequestListPage>
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
    _tabController = TabController(length: 3, vsync: this);
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
        title: Center(
          child: Text(
            "الطلبات",
            style: TextStyle(fontSize: 28),
          ),
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
            Tab(
              child: Text('تحت المراجعه',
                  style: GoogleFonts.nunitoSans(
                    color: const Color.fromARGB(255, 59, 59, 61),
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  )),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [Finished(), MInprogressPage(), InReview()],
      ),
    );
  }
}
