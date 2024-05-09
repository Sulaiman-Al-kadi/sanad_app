// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sanad_app/screans/admin-ui/add_location.dart';
import 'package:sanad_app/screans/admin-ui/add_employee.dart';
import 'package:sanad_app/screans/admin-ui/admin_home_page.dart';
import 'package:sanad_app/screans/admin-ui/admin_settings.dart';
import 'package:sanad_app/screans/admin-ui/create_department.dart';
import 'package:sanad_app/screans/admin-ui/dashboard.dart';
import 'package:sanad_app/screans/admin-ui/delete_category_entity.dart';
import 'package:sanad_app/screans/admin-ui/delete_location.dart';
import 'package:sanad_app/screans/admin-ui/department.dart';
import 'package:sanad_app/screans/admin-ui/edit_department.dart';
import 'package:sanad_app/screans/admin-ui/edit_employee.dart';
import 'package:sanad_app/screans/admin-ui/edit_location.dart';
import 'package:sanad_app/screans/admin-ui/employee.dart';
import 'package:sanad_app/screans/admin-ui/manage_location.dart';
import 'package:sanad_app/screans/admin-ui/new_category_entity.dart';
import 'package:sanad_app/screans/admin-ui/add_category.dart';
import 'package:sanad_app/screans/admin-ui/view_employee.dart';
import 'package:sanad_app/screans/admin-ui/view_location.dart';
import 'package:sanad_app/screans/forget_passwprd.dart';
import 'package:sanad_app/screans/login.dart';
import 'package:sanad_app/screans/maintenace-manager/add_employee.dart';
import 'package:sanad_app/screans/maintenace-manager/manager_dashboard.dart';
import 'package:sanad_app/screans/maintenace-manager/manager_homepage.dart';
import 'package:sanad_app/screans/maintenace-manager/manager_settings.dart';
import 'package:sanad_app/screans/maintenace-manager/manager_view_reqeust.dart';
import 'package:sanad_app/screans/maintenace-manager/mp_status.dart';
import 'package:sanad_app/screans/maintenace-personnel/mp_view_requests.dart';
import 'package:sanad_app/screans/maintenace-personnel/mp_dashbaord.dart';
import 'package:sanad_app/screans/maintenace-personnel/mp_homepage.dart';
import 'package:sanad_app/screans/maintenace-personnel/mp_settings.dart';
import 'package:sanad_app/screans/signup.dart';
import 'package:sanad_app/screans/user/make_new_request.dart';
import 'package:sanad_app/screans/user/rate_page.dart';
import 'package:sanad_app/screans/user/requestState.dart';
import 'package:sanad_app/screans/user/scan_qr_code.dart';
import 'package:sanad_app/screans/user/user_settings.dart';
import 'package:sanad_app/screans/user/user.dashbaord.dart';
import 'package:sanad_app/screans/user/user_homepage.dart';
import 'package:sanad_app/screans/admin-ui/add_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Get the current user's document ID from Firestore
String? getCurrentUserId() {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return user
        .uid; // Assuming the user ID is the same as the Firebase Authentication UID
  } else {
    return null;
  }
}

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
  "/user_new_request": (context) => const EnhancedRequestPage(),
  "/scan_qr_code": (context) => ScanQRPage(),
  "/user_request_state": (context) => TaskScreen(),
  "/rate_page": (context) => RatingPage(),
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
  "/admin_add_entity": (context) => MainPage(),
  "/admin_edit_employee": (context) => EditEmployee(),
  "/admin_view_location": (context) => LocationData(),
  "/admin_edit_location": (context) => EditLocationPage(),
  "/admin_employee": (context) => const Employee(),
  "/add_employee": (context) => AddEmplyee(),
  "/delete_category_entity": (context) => DeleteCategoryEntity(),
  "/delete_location": (context) => DeleteLocation(),
  "/view_employee": (context) => ViewEmployeesPage(),

  //mp
  "/mp_homepage": (context) => const MPHomepage(),
  "/mp_dashboard": (context) => const MPDashboard(),
  "/mp_settings": (context) => MPSettigns(),
  "/maintenance_personnel_page": (context) => MaintenancePersonnelPage(),

  //Manager
  "/manager_homepage": (context) => ManagerHomepage(),
  // "/mp_request_list": (context) => RequestListPage(),
  // "/mp_request_detail": (context) => RequestDetailPage(
  //       request: {},
  //       requestId: '',
  //       documentId: '',
  //     ),
  "/manager_settings": (context) => ManagerSettings(),
  "/manager_dashboard": (context) => const ManagerDashbaord(),
  "/manager_add_employee": (context) => const AddEmployeePage(),
  "/manager_change_available": (context) => ManagerMaintenancePersonnelPage(),
  // other routes
};
