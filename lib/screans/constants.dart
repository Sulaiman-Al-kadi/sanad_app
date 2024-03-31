import 'package:flutter/material.dart';
import 'package:sanad_app/screans/SettingsPage.dart';
import 'package:sanad_app/screans/admin-ui/admin_home_page.dart';
import 'package:sanad_app/screans/admin-ui/dashboard.dart';

class Nbar extends StatefulWidget {
  const Nbar({super.key});

  @override
  State<Nbar> createState() => _NbarState();
}

class _NbarState extends State<Nbar> {
  @override
  int _selectedIndex = 1;

  Widget build(BuildContext context) {
    return SafeArea(
      child: BottomNavigationBar(
        iconSize: 35,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 61, 30, 199),
        onTap: (index) => setState(() {
          _selectedIndex = index;
          if (_selectedIndex == 0) {
            selectedItemColor:
            Color.fromARGB(255, 61, 30, 199);

            // If "Settings" item is tapped
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  SettingsPage(), // Navigate to the settings page
            ));
          }
          if (_selectedIndex == 1) {
            selectedItemColor:
            Color.fromARGB(255, 61, 30, 199);
            // If "Settings" item is tapped
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  MyHomePage(), // Navigate to the settings page
            ));
          }
          if (_selectedIndex == 2) {
            selectedItemColor:
            Color.fromARGB(255, 61, 30, 199);
            // // If "Settings" item is tapped
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  dashboard(), // Navigate to the settings page
            ));
          }
        }),
      ),
    );
  }
}
