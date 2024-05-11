import 'package:flutter/material.dart';
import 'package:sanad_app/screans/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sanad_app/screans/login.dart';
import 'package:sanad_app/screans/navigation-bar/manager_nav_bar.dart';

class ManagerSettings extends StatefulWidget {
  const ManagerSettings({super.key});

  @override
  State<ManagerSettings> createState() => _SettingsPage();
}

class _SettingsPage extends State<ManagerSettings> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _logout() async {
    ManagerNBar a = new ManagerNBar();
    a.setManagerIndex(1);
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (route) => false,
    );
  }

  Future<void> _changePassword() async {
    // Implement password change logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الاعدادات"),
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: const ManagerNBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _logout,
              child: Text(
                'تسجيل الخروج',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changePassword,
              child: Text(
                'تغيير كلمة المرور',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
