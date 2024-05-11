import 'package:flutter/material.dart';

class MpNBar extends StatefulWidget {
  final int initialIndex;

  const MpNBar({Key? key, this.initialIndex = 1}) : super(key: key);
  void setMpSelectedIndex(int index) {
    _selectedIndex = index;
  }

  @override
  _MpNBarState createState() => _MpNBarState();
}

// Declare _selectedIndex at a scope that persists beyond the state of the MpNBar widget.
int _selectedIndex = 1;

class _MpNBarState extends State<MpNBar> {
  @override
  void initState() {
    super.initState();
    // Initialize _selectedIndex with widget's initialIndex on first build only if not already set.
    if (_selectedIndex == 1 && widget.initialIndex != 1) {
      _selectedIndex = widget.initialIndex;
    }
    print("Initial Index: $_selectedIndex");
  }

  void _navigateToPage(BuildContext context, int index) {
    print("Attempting to navigate to index: $index");

    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
        print("Index set to: $_selectedIndex");
      });

      // Trigger the navigation
      switch (index) {
        case 0:
          Navigator.of(context).pushReplacementNamed("/mp_settings");
          break;
        case 1:
          Navigator.of(context).pushReplacementNamed("/mp_homepage");
          break;
        case 2:
          Navigator.of(context).pushReplacementNamed("/mp_dashboard");
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
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          _navigateToPage(context, index);
        },
      ),
    );
  }
}
