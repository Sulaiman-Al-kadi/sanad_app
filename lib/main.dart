import 'package:flutter/material.dart';
import 'package:sanad_app/Routes.dart';
import 'package:sanad_app/screans/admin-ui/admin_home_page.dart';
import 'package:sanad_app/screans/admin-ui/dashboard.dart';
import 'package:sanad_app/screans/constants.dart';
import 'package:sanad_app/screans/forget_passwprd.dart';
import 'package:sanad_app/screans/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sanad_app/screans/maintenace-personnel/mp_homepage.dart';
import 'package:sanad_app/screans/signup.dart';
import 'package:sanad_app/screans/user/user_homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sanad',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: Login(),
      initialRoute: "/",
      routes: routes,
    );
  }
}
