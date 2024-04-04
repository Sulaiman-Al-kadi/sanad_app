// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sanad_app/screans/admin-ui/admin_home_page.dart';
import 'package:sanad_app/screans/admin-ui/admin_settings.dart';
import 'package:sanad_app/screans/admin-ui/dashboard.dart';
import 'package:sanad_app/screans/constants.dart';
import 'package:sanad_app/screans/forget_passwprd.dart';
import 'package:sanad_app/screans/login.dart';
import 'package:sanad_app/screans/maintenace-personnel/mp_dashbaord.dart';
import 'package:sanad_app/screans/maintenace-personnel/mp_homepage.dart';
import 'package:sanad_app/screans/maintenace-personnel/mp_settings.dart';
import 'package:sanad_app/screans/signup.dart';
import 'package:sanad_app/screans/user/SettingsPage.dart';
import 'package:sanad_app/screans/user/user.dashbaord.dart';
import 'package:sanad_app/screans/user/user_homepage.dart';
// import 'package:path/path.dart';

// extension NavigatorStateExtension on NavigatorState {

//   void pushNamedIfNotCurrent( String routeName, {required Object arguments} ) {
//     if (!isCurrent(routeName)) {
//       pushNamed( routeName, arguments: arguments );
//     }
//   }

//   bool isCurrent( String routeName ) {
//     bool isCurrent = false;
//     popUntil( (route) {
//       if (route.settings.name == routeName) {
//         isCurrent = true;
//       }
//       return true;
//     } );
//     return isCurrent;
//   }

// }
class Rout extends StatefulWidget {
  const Rout({super.key});

  @override
  State<Rout> createState() => _RoutState();
}

class _RoutState extends State<Rout> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

var routes = <String, WidgetBuilder>{
  "/": (context) => const Login(),
  "/signup": (context) => const Signup(),
  "/forget_ password": (context) => const Password(),
  //user :
  "/user_homepage": (context) => const UserHomePage(),
  "/user_settings": (context) => const UserSettingsPage(),
  "/user_dashboard": (context) => const UserDashboard(),
  //admin
  "/admin_homepage": (context) => const MyHomePage(),
  "/admin_dashboard": (context) => const Dashboard(),
  "/admin_settings": (context) => const AdminSettings(),
  //mp
  "/mp_homepage": (context) => const MPHomepage(),
  "/mp_dashboard": (context) => const MPDashboard(),
  "/mp_settings": (context) => const MPSettigns()
};
