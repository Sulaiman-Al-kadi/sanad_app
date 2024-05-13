import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sanad_app/screans/login.dart';
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
        title: Center(child: const Text("الإعدادات")),
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: UserNBar(), // Ensuring the settings index is active
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
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
                onTap: () => _logout(),
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
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePasswordPage(),
                  ),
                ),
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
      ),
    );
  }
}

class ChangePasswordPage extends StatelessWidget {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _changePassword(BuildContext context) async {
    String currentPassword = _currentPasswordController.text.trim();
    String newPassword = _newPasswordController.text.trim();

    try {
      // Reauthenticate the user with their current password before changing it
      AuthCredential credential = EmailAuthProvider.credential(
        email: _auth.currentUser!.email!,
        password: currentPassword,
      );
      await _auth.currentUser!.reauthenticateWithCredential(credential);

      // Change the password
      await _auth.currentUser!.updatePassword(newPassword);

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم تغيير كلمة المرور بنجاح'),
          duration: Duration(seconds: 3),
        ),
      );

      // Navigate back to previous screen
      Navigator.pop(context);
    } catch (error) {
      // Show an error message if changing the password fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('فشل تغيير كلمة المرور. الرجاء المحاولة مرة أخرى'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تغيير كلمة المرور'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _currentPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'كلمة المرور الحالية'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'كلمة المرور الجديدة'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _changePassword(context),
              child: Text('تغيير كلمة المرور'),
            ),
          ],
        ),
      ),
    );
  }
}
