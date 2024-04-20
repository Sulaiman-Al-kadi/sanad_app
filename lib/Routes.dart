// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sanad_app/screans/admin-ui/add_location.dart';
import 'package:sanad_app/screans/admin-ui/add_employee.dart';
import 'package:sanad_app/screans/admin-ui/admin_home_page.dart';
import 'package:sanad_app/screans/admin-ui/admin_settings.dart';
import 'package:sanad_app/screans/admin-ui/create_department.dart';
import 'package:sanad_app/screans/admin-ui/dashboard.dart';
import 'package:sanad_app/screans/admin-ui/department.dart';
import 'package:sanad_app/screans/admin-ui/edit_department.dart';
import 'package:sanad_app/screans/admin-ui/edit_employee.dart';
import 'package:sanad_app/screans/admin-ui/edit_location.dart';
import 'package:sanad_app/screans/admin-ui/employee.dart';
import 'package:sanad_app/screans/admin-ui/manage_location.dart';
import 'package:sanad_app/screans/admin-ui/new_category_entity.dart';
import 'package:sanad_app/screans/admin-ui/add_category.dart';
import 'package:sanad_app/screans/admin-ui/view_location.dart';
import 'package:sanad_app/screans/forget_passwprd.dart';
import 'package:sanad_app/screans/login.dart';
import 'package:sanad_app/screans/maintenace-personnel/mp_dashbaord.dart';
import 'package:sanad_app/screans/maintenace-personnel/mp_homepage.dart';
import 'package:sanad_app/screans/maintenace-personnel/mp_settings.dart';
import 'package:sanad_app/screans/signup.dart';
import 'package:sanad_app/screans/user/user_settings.dart';
import 'package:sanad_app/screans/user/user.dashbaord.dart';
import 'package:sanad_app/screans/user/user_homepage.dart';
import 'package:sanad_app/screans/admin-ui/add_entity.dart';

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
  //"/": (context) => const Login(),
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
  "/admin_location": (context) => const ManageLocation(),
  "/admin_department": (context) => const Department(),
  "/edit_depatment": (context) => EditDepartment(),
  "/craete_department": (context) => CreateDepartment(),
  "/add_location": (context) => AddLocation(),
  "/admin_category_enitity": (context) => const CategoryAndEntity(),
  "/admin_add_category": (context) => ChangeCategoryEntity(),
  "/admin_add_entity": (context) => AddEntity(),
  "/admin_edit_employee": (context) => EditEmployee(),
  "/admin_view_location": (context) => LocationData(),
  "/admin_edit_location": (context) => EditLocationPage(),

  "/admin_employee": (context) => const Employee(),
  "/add_employee": (context) => AddEmplyee(),

  //mp
  "/mp_homepage": (context) => const MPHomepage(),
  "/mp_dashboard": (context) => const MPDashboard(),
  "/mp_settings": (context) => MPSettigns()
};
