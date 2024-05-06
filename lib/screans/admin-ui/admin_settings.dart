// import 'package:flutter/material.dart';
// import 'package:sanad_app/screans/constants.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:sanad_app/screans/login.dart';

// class AdminSettings extends StatefulWidget {
//   const AdminSettings({Key? key});

//   @override
//   State<AdminSettings> createState() => _AdminSettingsState();
// }

// class _AdminSettingsState extends State<AdminSettings> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   void _logout() async {
//     await _auth.signOut();
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => Login()),
//       (route) => false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("الاعدادات"),
//         backgroundColor: Colors.blue,
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _logout,
//           child: Text(
//             'تسجيل الخروج',
//             style: TextStyle(fontSize: 20),
//           ),
//         ),
//       ),
//       bottomNavigationBar: const Nbar(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sanad_app/screans/constants.dart';
import 'package:sanad_app/screans/login.dart';
import 'package:sanad_app/screans/navigation-bar/admin_nav_bar.dart';

class AdminSettings extends StatefulWidget {
  const AdminSettings({Key? key});

  @override
  State<AdminSettings> createState() => _AdminSettingsState();
}

class _AdminSettingsState extends State<AdminSettings> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _logout() async {
    AdminNBar t = new AdminNBar();
    t.setAdminSelectedIndex(1);

    await _auth.signOut();
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Login();
        },
      ),
      (_) => false,
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
      bottomNavigationBar: const AdminNBar(),
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
