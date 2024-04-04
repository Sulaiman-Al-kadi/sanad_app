import 'package:flutter/material.dart';
import 'package:sanad_app/screans/constants.dart';

class UserSettingsPage extends StatefulWidget {
  const UserSettingsPage({super.key});

  @override
  State<UserSettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<UserSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("UserSettingsPage"), backgroundColor: Colors.blue),
      bottomNavigationBar: const Nbar(),

      // bottomNavigationBar: FlashyTabBar(
      //   selectedIndex: selectedIndex,
      //   showElevation: true,
      //   onItemSelected: (index) => setState(() {
      //     selectedIndex = index;
      //     if (selectedIndex == 0) {
      //       // If "Settings" item is tapped
      //       Navigator.of(context).pushReplacement(MaterialPageRoute(
      //         builder: (context) =>
      //             MyHomePage(), // Navigate to the settings page
      //       ));
      //     }
      //   }),
      //   items: [
      //     FlashyTabBarItem(
      //       icon: Icon(
      //         Icons.home,
      //         size: 30,
      //       ),
      //       title: Text('Home'),
      //     ),
      //     FlashyTabBarItem(
      //       icon: Icon(
      //         Icons.settings,
      //         size: 30,
      //       ),
      //       title: Text('Settings'),
      //     ),
      //   ],
      // ),
    );
  }
}
