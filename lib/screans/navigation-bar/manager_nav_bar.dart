import 'package:flutter/material.dart';

// Global index for ManagerNBar
int _managerSelectedIndex = 1;

class ManagerNBar extends StatefulWidget {
  final int initialIndex;

  const ManagerNBar({Key? key, this.initialIndex = 1}) : super(key: key);
    void setManagerIndex(int index) {
    _managerSelectedIndex = index;
  }
  @override
  _ManagerNBarState createState() => _ManagerNBarState();
}

class _ManagerNBarState extends State<ManagerNBar> {

  @override
  void initState() {
    super.initState();
    if (_managerSelectedIndex == 1 && widget.initialIndex != 1) {
      _managerSelectedIndex = widget.initialIndex;
    }
  }

  void _navigateToPage(BuildContext context, int index) {
    if (_managerSelectedIndex != index) {
      setState(() {
        _managerSelectedIndex = index;
      });

      switch (index) {
        case 0:
          Navigator.of(context).pushReplacementNamed("/manager_settings");
          break;
        case 1:
          Navigator.of(context).pushReplacementNamed("/manager_homepage");
          break;
        case 2:
          Navigator.of(context).pushReplacementNamed("/manager_dashboard");
          break;
        default:
          print("Invalid index: $index");
          break;
      }
    }
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
        currentIndex: _managerSelectedIndex,
        selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          _navigateToPage(context, index);
        },
      ),
    );
  }
}
