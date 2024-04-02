import 'package:flutter/material.dart';
import 'package:sanad_app/main.dart';
import 'package:sanad_app/screans/SettingsPage.dart';
import 'package:sanad_app/screans/admin-ui/admin_home_page.dart';
import 'package:sanad_app/screans/admin-ui/dashboard.dart';
import 'package:sanad_app/screans/constants.dart';
import 'package:sanad_app/screans/forget_passwprd.dart';
import 'package:sanad_app/screans/login.dart';
import 'package:sanad_app/screans/maintenace-personnel/mp_homepage.dart';
import 'package:sanad_app/screans/signup.dart';
import 'package:sanad_app/screans/user/user_homepage.dart';
import "package:sanad_app/screans/constants.dart";

var routes = <String, WidgetBuilder>{
  "/": (context) => const UserHomePage(),
  "settings": (context) => const SettingsPage(),
  "/login": (context) => const Login(),
  "/signup": (context) => const Signup(),
  "/forget_ password": (context) => const Password(),
  "/constant": (context) => const Nbar(),
  "/admin_home_page": (context) => MyHomePage(),
  "/admin_dashbaord": (context) => const Dashboard(),
  "/mp_homepage": (context) => const MPHomepage(),
};
// P() {
//   if (routes.keys == "admin_home_page" && routes.keys == "admin_dashbaord") {
//     isAdmin = true;
//     print("admin");
//     if (routes.keys == "mp_homepage") {
//       isMP = true;
//       print("MP");
//     }
//     if (routes[1] == "/") {
//       print(routes.keys);
//       isUser = true;
//     }
//   } else {
//     return print(routes.keys);
//   }
// }
