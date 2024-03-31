import 'package:flutter/material.dart';
import 'package:sanad_app/screans/constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("SettingsPage"), backgroundColor: Colors.blue),
      bottomNavigationBar: Nbar(),

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
