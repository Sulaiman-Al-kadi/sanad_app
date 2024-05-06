

import 'package:flutter/material.dart';

// Global index for AdminNBar
 int _adminSelectedIndex = 1;
class AdminNBar extends StatefulWidget {
  const AdminNBar({super.key});
  void setAdminSelectedIndex(int index) {
    _adminSelectedIndex = index;
  }

  @override
  _AdminNBarState createState() => _AdminNBarState();
}

class _AdminNBarState extends State<AdminNBar> {
 
  @override
  void initState() {
    super.initState();
  }

  
  void _navigateToPage(BuildContext context, int index) {
    print("the index = $index");

    switch (index) {
      case 0:
        _adminSelectedIndex = 0;
        Navigator.of(context).pushReplacementNamed("/admin_settings");
        break;
      case 1:
        _adminSelectedIndex = 1;
        Navigator.of(context).pushReplacementNamed("/admin_homepage");
        break;
      case 2:
        _adminSelectedIndex = 2;
        Navigator.of(context).pushReplacementNamed("/admin_dashboard");
        break;
      default:
        print("Invalid index: $index");
        break;
    }
    setState(() {
      _adminSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BottomNavigationBar(
        iconSize: 35,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'الإعدادات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'صفحة البيانات',
          ),
        ],
        currentIndex: _adminSelectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          _navigateToPage(context, index);
        },
      ),
    );
  }
}
