import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sanad_app/screans/login.dart';
import 'package:sanad_app/screans/navigation-bar/maintenace_nav_bar.dart';

class MPSettigns extends StatelessWidget {
  MPSettigns({Key? key}) : super(key: key);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _logout(BuildContext context) async {
    
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) =>
              Login()), // Redirects user to the Login page after logout
      (route) => false,
    );
  }

  Future<void> _changePassword(BuildContext context) async {
    // Implement password change logic
    // Placeholder for changing password logic
    // Typically, you might show a dialog or navigate to a password change screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الإعدادات"),
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar:
          MpNBar(initialIndex: 0), // Ensuring the settings index is active
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => _logout(context),
              child: const Text(
                'تسجيل الخروج',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _changePassword(context),
              child: const Text(
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
