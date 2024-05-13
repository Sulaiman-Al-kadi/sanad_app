import 'package:flutter/material.dart';

import 'package:sanad_app/screans/navigation-bar/manager_nav_bar.dart';

class ManagerDashbaord extends StatelessWidget {
  const ManagerDashbaord({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("لوحة التحكم")),
      ),
      bottomNavigationBar: ManagerNBar(),
    );
  }
}
