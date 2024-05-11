import 'package:flutter/material.dart';

// Global index for UserNBar
int _userSelectedIndex = 1;

class UserNBar extends StatefulWidget {
  final int initialIndex;

  const UserNBar({Key? key, this.initialIndex = 1}) : super(key: key);

  @override
  _UserNBarState createState() => _UserNBarState();
}

class _UserNBarState extends State<UserNBar> {
  @override
  void initState() {
    super.initState();
    if (_userSelectedIndex == 1 && widget.initialIndex != 1) {
      _userSelectedIndex = widget.initialIndex;
    }
  }

  void _navigateToPage(BuildContext context, int index) {
    if (_userSelectedIndex != index) {
      setState(() {
        _userSelectedIndex = index;
      });

      switch (index) {
        case 0:
          Navigator.of(context).pushReplacementNamed("/user_settings");
          break;
        case 1:
          Navigator.of(context).pushReplacementNamed("/user_homepage");
          break;
        case 2:
          Navigator.of(context).pushReplacementNamed("/user_dashboard");
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

        ],
        currentIndex: _userSelectedIndex,
        selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          _navigateToPage(context, index);
        },
      ),
    );
  }
}
