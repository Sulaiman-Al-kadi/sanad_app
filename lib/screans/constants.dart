// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:sanad_app/routes.dart';
// import 'package:sanad_app/screans/admin-ui/dashboard.dart';
// import 'package:sanad_app/screans/login.dart';
// import 'package:sanad_app/screans/user/user_homepage.dart';

// bool isAdmin = false;
// bool isUser = false;
// bool isMP = false;

// String? P() {
//   var userTypeChecker = ModalRoute.of(context as BuildContext)?.settings.name;
//   switch (userTypeChecker) {
//     case "/admin_homepage":
//       {
//         isAdmin = true;
//       }
//       break;
//     case "/admin_dashbaord":
//       {
//         isAdmin = true;
//       }
//       break;
//     case "/admin_settings":
//       {
//         isAdmin = true;
//       }
//       break;
//     case "/mp_homepage":
//       {
//         isMP = true;
//       }
//       break;
//     case "/mp_dashboard":
//       {
//         isMP = true;
//       }
//       break;
//     case "/mp_settings":
//       {
//         isMP = true;
//       }
//       break;

//     case "/user_homepage":
//       {
//         isUser = true;
//       }
//       break;
//     case "/user_settings":
//       {
//         isUser = true;
//       }
//       break;
//     case "/user_dashbaord":
//       {
//         isUser = true;
//       }
//       break;

//     default:
//       {
//         print("error unknown user type");
//       }
//   }
//   return userTypeChecker;
// }

// class Nbar extends StatefulWidget {
//   const Nbar({super.key});

//   @override
//   State<Nbar> createState() => _NbarState();
// }
// class _NbarState extends State<Nbar> {
//   @override
//  int _selectedIndex = 1;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: BottomNavigationBar(
//         iconSize: 35,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.history),
//             label: 'History',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: const Color.fromARGB(255, 61, 30, 199),
//         onTap: (index) => setState(() {
//           _selectedIndex = index;
//           if (_selectedIndex == 0) {
//             selectedItemColor:
//             const Color.fromARGB(255, 61, 30, 199);
//             if (P() == isAdmin) {
//               Navigator.of(context).pushNamed("/Admin_homepage");
//             }
//             if (P() == isUser) {
//               Navigator.of(context).pushNamed("/user_dashbaord");
//             }

//             // If "Settings" item is tapped

//             // Navigator.of(context).push(MaterialPageRoute(
//             //   builder: (context) => UserSettingsPage(),
//             //   // Navigate to the settings page
//             // ));
//           }
//           if (_selectedIndex == 1) {
//             selectedItemColor:
//             const Color.fromARGB(255, 61, 30, 199);
//             // If "Settings" item is tapped
//             if (ModalRoute.of(context) == const UserHomePage()) {
//               Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) =>
//                      Login(), // Navigate to the settings page
//               ));
//             }
//           }
//           if (_selectedIndex == 2) {
//             selectedItemColor:
//             const Color.fromARGB(255, 61, 30, 199);
//             // // If "Settings" item is tapped
//             // Navigator.of(context).push(MaterialPageRoute(
//             //   builder: (context) =>
//             //        Dashboard(), // Navigate to the settings page
//             // ));
//           }
//         })//,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:sanad_app/screans/admin-ui/dashboard.dart';
import 'package:sanad_app/screans/login.dart';
import 'package:sanad_app/screans/maintenace-personnel/mp_dashbaord.dart';
import 'package:sanad_app/screans/user/user_homepage.dart';

bool isAdmin = false;
bool isUser = false;
bool isMP = false;

// DETRMINE THE TYPE OF USER
userGuider(BuildContext context) {
  var userTypeChecker = ModalRoute.of(context)?.settings.name;
  switch (userTypeChecker) {
    case "/admin_homepage":
    case "/admin_dashboard":
    case "/admin_settings":
      isAdmin = true;
      print("is admin");

      break;
    case "/mp_homepage":
    case "/mp_dashboard":
    case "/mp_settings":
      isMP = true;
      print("is mp");

      break;
    case "/user_homepage":
    case "/user_settings":
    case "/user_dashboard":
      isUser = true;
      print("is user");
      break;
    default:
      print("error unknown user type");
  }
  return userTypeChecker;
}

class Nbar extends StatefulWidget {
  const Nbar({Key? key}) : super(key: key);

  @override
  _NbarState createState() => _NbarState();
}

class _NbarState extends State<Nbar> {
  static int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BottomNavigationBar(
        iconSize: 35,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'الاعدادات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'العمليات الاخيرة',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 61, 30, 199),
        onTap: (index) {
          setState(() {
            userGuider(context);
            _selectedIndex = index;
            if (_selectedIndex == 0) {
              if (isAdmin) {
                Navigator.of(context).popAndPushNamed("/admin_settings");
              }
              if (isUser) {
                Navigator.of(context).pushReplacementNamed("/user_settings");
              }
              if (isMP) {
                Navigator.of(context).popAndPushNamed("/mp_settings");
              }
            }
            if (_selectedIndex == 1) {
              if (isAdmin) {
                Navigator.of(context).popAndPushNamed("/admin_homepage");
              }
              if (isUser) {
                Navigator.of(context).popAndPushNamed("/user_homepage");
              }
              if (isMP) {
                Navigator.of(context).popAndPushNamed("/mp_homepage");
              }
            }
            if (_selectedIndex == 2) {
              if (isAdmin) {
                Navigator.of(context).popAndPushNamed("/admin_dashboard");
              }
              if (isUser) {
                Navigator.of(context).popAndPushNamed("/user_dashboard");
              }
              if (isMP) {
                Navigator.of(context).popAndPushNamed("/mp_dashboard");
              }
            }
          });
        },

      ),
    );
  }
}
