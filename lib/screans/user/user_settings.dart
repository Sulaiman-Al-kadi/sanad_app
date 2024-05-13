import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sanad_app/screans/login.dart';
import 'package:sanad_app/screans/navigation-bar/maintenace_nav_bar.dart';
import 'package:sanad_app/screans/navigation-bar/user_nav_bar.dart';

class UserSettingsPage extends StatefulWidget {
  const UserSettingsPage({super.key});

  @override
  State<UserSettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<UserSettingsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<void> _changePassword() async {
    // Implement password change logic
  }

  void _logout() async {
    UserNBar u = new UserNBar();
    u.setUserSelectedIndex(1);
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (route) => false,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("الاعدادات")),
      ),
      bottomNavigationBar: const UserNBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              title: Text(
                'تسجيل الخروج',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              leading: Icon(Icons.logout),
              onTap: _logout,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              tileColor: Colors.blue.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              dense: true,
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text(
                'تغيير كلمة المرور',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              leading: Icon(Icons.lock),
              onTap: _changePassword,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              tileColor: Colors.blue.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              dense: true,
            ),
          ],
        ),
      ),
    );
  }
}
