import 'package:flutter/material.dart';
import 'package:sanad_app/screans/constants.dart';
import 'package:sanad_app/screans/navigation-bar/maintenace_nav_bar.dart';

class MPDashboard extends StatefulWidget {
  const MPDashboard({super.key});

  @override
  State<MPDashboard> createState() => _MPDashboardState();
}

class _MPDashboardState extends State<MPDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(" DASHBAORD فني الصيانة")),
      bottomNavigationBar: MpNBar(),
    );
  }
}
