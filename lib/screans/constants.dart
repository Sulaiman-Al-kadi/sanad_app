// import 'package:flutter/material.dart';

// class AdminNBar extends StatefulWidget {
//   const AdminNBar({Key? key}) : super(key: key);

//   @override
//   _AdminNBarState createState() => _AdminNBarState();
// }

// class _AdminNBarState extends State<AdminNBar> {
//   static int _selectedIndex = 1;

//   void _navigateToPage(BuildContext context, int index) {
//     switch (index) {
//       case 0:
//         Navigator.of(context).pushReplacementNamed("/admin_settings");
//         break;
//       case 1:
//         Navigator.of(context).pushReplacementNamed("/admin_homepage");
//         break;
//       case 2:
//         Navigator.of(context).pushReplacementNamed("/admin_dashboard");
//         break;
//       default:
//         print("not in correct positions: $index");
//         _selectedIndex = 1;
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _buildBottomNavigationBar(context, _navigateToPage);
//   }

//   Widget _buildBottomNavigationBar(
//       BuildContext context, void Function(BuildContext, int) navigateToPage) {
//     return SafeArea(
//       child: BottomNavigationBar(
//         iconSize: 35,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'الإعدادات',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'الرئيسية',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.analytics),
//             label: 'صفحة البيانات',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
//         unselectedItemColor: Colors.grey,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//             navigateToPage(context, _selectedIndex);
//           });
//         },
//       ),
//     );
//   }
// }

// class ManagerNBar extends StatefulWidget {
//   const ManagerNBar({Key? key}) : super(key: key);

//   @override
//   _ManagerNBarState createState() => _ManagerNBarState();
// }

// class _ManagerNBarState extends State<ManagerNBar> {
//   static int _selectedIndex = 1;

//   void _navigateToPage(BuildContext context, int index) {
//     switch (index) {
//       case 0:
//         Navigator.of(context).pushReplacementNamed("/manager_settings");
//         break;
//       case 1:
//         Navigator.of(context).pushReplacementNamed("/manager_homepage");
//         break;
//       case 2:
//         Navigator.of(context).pushReplacementNamed("/manager_dashboard");
//         break;
//       default:
//         print("not in correct positions: $index");
//         _selectedIndex = 1;
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _buildBottomNavigationBar(context, _navigateToPage);
//   }

//   Widget _buildBottomNavigationBar(
//       BuildContext context, void Function(BuildContext, int) navigateToPage) {
//     return SafeArea(
//       child: BottomNavigationBar(
//         iconSize: 35,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'الإعدادات',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'الرئيسية',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.analytics),
//             label: 'صفحة البيانات',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
//         unselectedItemColor: Colors.grey,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//             navigateToPage(context, _selectedIndex);
//           });
//         },
//       ),
//     );
//   }
// }

// class MpNBar extends StatefulWidget {
//   const MpNBar({Key? key}) : super(key: key);

//   @override
//   _MpNBarState createState() => _MpNBarState();
// }

// class _MpNBarState extends State<MpNBar> {
//   static int _selectedIndex = 1;

//   void _navigateToPage(BuildContext context, int index) {
//     switch (index) {
//       case 0:
//         Navigator.of(context).pushReplacementNamed("/mp_settings");
//         break;
//       case 1:
//         Navigator.of(context).pushReplacementNamed("/mp_homepage");
//         break;
//       case 2:
//         Navigator.of(context).pushReplacementNamed("/mp_dashboard");
//         break;
//       default:
//         print("not in correct positions: $index");
//         _selectedIndex = 1;
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _buildBottomNavigationBar(context, _navigateToPage);
//   }

//   Widget _buildBottomNavigationBar(
//       BuildContext context, void Function(BuildContext, int) navigateToPage) {
//     return SafeArea(
//       child: BottomNavigationBar(
//         iconSize: 35,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'الإعدادات',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'الرئيسية',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.analytics),
//             label: 'صفحة البيانات',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
//         unselectedItemColor: Colors.grey,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//             navigateToPage(context, _selectedIndex);
//           });
//         },
//       ),
//     );
//   }
// }

// class UserNBar extends StatefulWidget {
//   const UserNBar({Key? key}) : super(key: key);

//   @override
//   _UserNBarState createState() => _UserNBarState();
// }

// class _UserNBarState extends State<UserNBar> {
//   static int _selectedIndex = 1;

//   void _navigateToPage(BuildContext context, int index) {
//     switch (index) {
//       case 0:
//         Navigator.of(context).pushReplacementNamed("/user_settings");
//         break;
//       case 1:
//         Navigator.of(context).pushReplacementNamed("/user_homepage");
//         break;
//       case 2:
//         Navigator.of(context).pushReplacementNamed("/user_dashboard");
//         break;
//       default:
//         print("not in correct positions: $index");
//         _selectedIndex = 1;
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _buildBottomNavigationBar(context, _navigateToPage);
//   }

//   Widget _buildBottomNavigationBar(
//       BuildContext context, void Function(BuildContext, int) navigateToPage) {
//     return SafeArea(
//       child: BottomNavigationBar(
//         iconSize: 35,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'الإعدادات',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'الرئيسية',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.analytics),
//             label: 'صفحة البيانات',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
//         unselectedItemColor: Colors.grey,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//             navigateToPage(context, _selectedIndex);
//           });
//         },
//       ),
//     );
//   }
// }
