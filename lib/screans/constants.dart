import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sanad_app/main.dart';
import 'package:sanad_app/screans/SettingsPage.dart';
import 'package:sanad_app/screans/admin-ui/admin_home_page.dart';
import 'package:sanad_app/screans/admin-ui/dashboard.dart';
import 'package:sanad_app/screans/login.dart';
import 'package:sanad_app/screans/user/user_homepage.dart';

bool isAdmin = false;
bool isUser = false;
bool isMP = false;

class Nbar extends StatefulWidget {
  const Nbar({super.key});

  @override
  State<Nbar> createState() => _NbarState();
}

class _NbarState extends State<Nbar> {
  @override
  static int _selectedIndex = 1;

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
            if (ModalRoute.of(context) == UserHomePage()) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Login(), // Navigate to the settings page
              ));
            }
          }
          if (_selectedIndex == 2) {
            selectedItemColor:
            Color.fromARGB(255, 61, 30, 199);
            // // If "Settings" item is tapped
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  Dashboard(), // Navigate to the settings page
            ));
          }
        }),
      ),
      
    );
  }
}
