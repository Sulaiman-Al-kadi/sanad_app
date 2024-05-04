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

bool isAdmin = false;
bool isUser = false;
bool isMP = false;
bool isM = false;

// DETERMINE THE TYPE OF USER
void userGuider(BuildContext context) {
  var userTypeChecker = ModalRoute.of(context)?.settings.name;
  switch (userTypeChecker) {
    case "/admin_homepage":
    case "/admin_dashboard":
    case "/admin_settings":
      isAdmin = true;
      break;
    case "/mp_homepage":
    case "/mp_dashboard":
    case "/mp_settings":
      isMP = true;
      break;
    case "/user_homepage":
    case "/user_settings":
    case "/user_dashboard":
      isUser = true;
      break;
    case "/manager_homepage":
    case "/manager_settings":
    case "/manager_dashboard":
      isM = true;
      break;
    default:
      print("error unknown user type");
  }
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
            icon: Icon(Icons.analytics),
            label: 'صفحة البيانات ',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 0, 0, 0),
        unselectedItemColor: Colors.grey, // Add unselected item color
        onTap: (index) {
          setState(() {
            userGuider(context);
            _selectedIndex = index;
            switch (_selectedIndex) {
              case 0:
                if (isAdmin) {
                  Navigator.of(context).pushReplacementNamed("/admin_settings");
                } else if (isUser) {
                  Navigator.of(context).pushReplacementNamed("/user_settings");
                } else if (isMP) {
                  Navigator.of(context).pushReplacementNamed("/mp_settings");
                } else if (isM) {
                  Navigator.of(context)
                      .pushReplacementNamed("/manager_settings");
                }
                break;
              case 1:
                if (isAdmin) {
                  Navigator.of(context).pushReplacementNamed("/admin_homepage");
                } else if (isUser) {
                  Navigator.of(context).pushReplacementNamed("/user_homepage");
                } else if (isMP) {
                  Navigator.of(context).pushReplacementNamed("/mp_homepage");
                } else if (isM) {
                  Navigator.of(context)
                      .pushReplacementNamed("/manager_homepage");
                }
                break;
              case 2:
                if (isAdmin) {
                  Navigator.of(context)
                      .pushReplacementNamed("/admin_dashboard");
                } else if (isUser) {
                  Navigator.of(context).pushReplacementNamed("/user_dashboard");
                } else if (isMP) {
                  Navigator.of(context).pushReplacementNamed("/mp_dashboard");
                } else if (isM) {
                  Navigator.of(context)
                      .pushReplacementNamed("/manager_dashboard");
                }
                break;
              default:
                print("not in correct positions: $_selectedIndex");
                break;
            }
          });
        },
      ),
    );
  }
}
